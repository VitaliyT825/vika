grant all on *.* to 'mysql_user'@'%';
flush privileges;

create database aramuz_db;
create database bireport_db;

create table aramuz_db.Player
(
    id                    bigint unsigned                              not null
        primary key,
    email                 varchar(255)                                 not null,
    password              varchar(255)                                 not null,
    country               varchar(255)                                 not null,
    receiveEmails         tinyint(1)                  default 0        not null,
    createdAt             datetime                                     not null,
    updatedAt             datetime                                     not null,
    wlId                  bigint unsigned                              not null,
    firstName             varchar(255)                default ''       not null,
    lastName              varchar(255)                default ''       not null,
    birthDate             date                                         null,
    gender                enum ('male', 'female')                      null comment '(DC2Type:player_gender_enum_type)',
    city                  varchar(255)                default ''       not null,
    address               varchar(255)                default ''       not null,
    postalCode            varchar(255)                default ''       not null,
    receiveSms            tinyint(1)                  default 0        not null,
    emailConfirmed        tinyint(1)                  default 0        not null,
    cellxpertId           varchar(255)                default ''       not null,
    registerClientIp      varchar(255)                default ''       not null,
    requirePasswordChange tinyint(1)                  default 0        not null,
    status                enum ('active', 'disabled') default 'active' not null comment '(DC2Type:player_status_enum_type)',
    emailConfirmCode      varchar(64)                 default ''       not null,
    twoFactorEnabled      tinyint(1)                  default 0        not null,
    twoFactorSecretKey    varchar(255)                                 null,
    phoneNumber           varchar(255)                default ''       not null,
    constraint UNIQ_9FB57F53E7927C74FD052470
        unique (email, wlId)
)
    collate = utf8mb4_unicode_ci;

create index IDX_9FB57F532392A156FD052470
    on aramuz_db.Player (firstName(20), wlId);

create index IDX_9FB57F532D5B0234FD052470
    on aramuz_db.Player (city(20), wlId);

create index IDX_9FB57F5391161A88FD052470
    on aramuz_db.Player (lastName(20), wlId);

create index IDX_9FB57F53D4E6F81FD052470
    on aramuz_db.Player (address(20), wlId);

create index IDX_9FB57F53FD052470
    on aramuz_db.Player (wlId);

create table aramuz_db.PlayerLimit
(
    id               bigint unsigned                                                                                                                  not null
        primary key,
    type             enum ('depositLimit', 'sessionLimit', 'wagerLimit', 'selfExclusionLimit', 'lossLimit', 'coolingOffLimit') default 'depositLimit' not null comment '(DC2Type:limit_type_enum_type)',
    `period` enum ('noLimit', 'dayLimit', 'weekLimit', 'monthLimit') default 'dayLimit' not null comment '(DC2Type:limit_period_enum_type)',
    refreshAt        datetime                                                                                                                         null,
    cancelAt         datetime                                                                                                                         null,
    createdAt        datetime                                                                                                                         not null,
    updatedAt        datetime                                                                                                                         not null,
    playerId         bigint unsigned                                                                                                                  not null,
    value            bigint                                                                                                                           null,
    currentValue     bigint                                                                                                                           null,
    nextValue        bigint                                                                                                                           null,
    nextValueApplyAt datetime                                                                                                                         null,
    constraint UNIQ_C7F4689B8CDE5729C5B81ECE82E7DC2B
        unique (type, period, playerId),
    constraint FK_C7F4689B82E7DC2B
        foreign key (playerId) references Player (id)
)
    collate = utf8mb4_unicode_ci;

create index IDX_C7F4689B82E7DC2B
    on aramuz_db.PlayerLimit (playerId);

create table aramuz_db.Tag
(
    id          bigint unsigned                            not null
        primary key,
    name        varchar(255)              default ''       not null,
    object      enum ('player', 'game')                    not null comment '(DC2Type:tag_object_enum_type)',
    type        enum ('system', 'manual') default 'manual' not null comment '(DC2Type:tag_type_enum_type)',
    objectCount varchar(255)              default '0'      not null,
    createdAt   datetime                                   not null,
    updatedAt   datetime                                   not null,
    wlId        bigint unsigned                            null,
    constraint UNIQ_3BC4F1635E237E068CDE5729A8ADABECFD052470
        unique (name, type, object, wlId)
)
    collate = utf8mb4_unicode_ci;

create index IDX_3BC4F163FD052470
    on aramuz_db.Tag (wlId);

create table aramuz_db.TagObject
(
    id        bigint unsigned not null
        primary key,
    objectId  bigint unsigned not null,
    createdAt datetime        not null,
    updatedAt datetime        not null,
    tagId     bigint unsigned not null,
    constraint UNIQ_8524D9E36F16ADDC99722DDF
        unique (tagId, objectId),
    constraint FK_8524D9E36F16ADDC
        foreign key (tagId) references aramuz_db.Tag (id)
)
    collate = utf8mb4_unicode_ci;

create index IDX_8524D9E36F16ADDC
    on aramuz_db.TagObject (tagId);

create index IDX_8524D9E399722DDF
    on aramuz_db.TagObject (objectId);

create table bireport_db.ClickHouseDashboardDataMartByDate
(
    id                      bigint unsigned auto_increment
        primary key,
    date                    date                               not null,
    playerId                bigint                             not null,
    affiliatePlayerId       int                                null,
    campaignId              bigint                             null,
    source                  varchar(255)                       null,
    FTDS                    double                             null,
    DC                      double                             null,
    DS                      double                             null,
    BS                      double                             null,
    WS                      double                             null,
    bonuses                 double                             null,
    GGR                     double                             null,
    RNGR                    double                             null,
    gameProviderFee         double                             null,
    paymentSystemFee        double                             null,
    BC                      double                             null,
    FTDAt                   date                               null,
    COS                     double                             null,
    ADS                     double                             null,
    isVIP                   smallint                           not null,
    isM1D                   smallint                           null,
    countryName             varchar(255)                       null,
    partnerId               varchar(255)                       null,
    partnerName             longtext                           null,
    manager                 varchar(255)                       null,
    managerEmail            longtext                           null,
    brandName               varchar(255)                       not null,
    teamId                  varchar(255)                       null,
    buyerId                 varchar(255)                       null,
    regAt                   date                               null,
    isReg                   bigint                             null,
    isFTD                   bigint                             null,
    LBAt                    date                               null,
    cohFilter               date                               null,
    deal                    longtext                           null,
    CPA                     double                             null,
    RS                      double                             null,
    isBL                    smallint                           null,
    BL                      double                             null,
    CNGRwithVAT             double                             null,
    CNGR                    double                             null,
    CNGRtrue                double                             null,
    UIDInCasino             varchar(255)                       null,
    email                   longtext                           null,
    phone                   varchar(255)                       null,
    firstName               longtext                           null,
    lastName                longtext                           null,
    age                     double                             null,
    isBef30                 smallint                           null,
    isBetw30and39           smallint                           null,
    isBetw40and54           smallint                           null,
    isAft55                 smallint                           null,
    isMan                   smallint                           null,
    isWmn                   smallint                           null,
    gender                  varchar(255)                       null,
    birthday                date                               null,
    isVIPMax                smallint                           null,
    isVIPTed                smallint                           null,
    isVIPAdele              smallint                           null,
    isVIPLam                smallint                           null,
    isVIPDav                smallint                           null,
    isVIPSandra             smallint                           null,
    isVIPMorris             smallint                           null,
    isVIPLarry              smallint                           null,
    isVIPDaniel             smallint                           null,
    isVIPKevin              smallint                           null,
    isVIPJaha               smallint                           null,
    isVIPAlan               smallint                           null,
    isVIPAnneMarie          smallint                           null,
    VipGroupDate            date                               null,
    isQual                  smallint                           null,
    Activity                double                             null,
    CPAreward               double                             null,
    RSreward                double                             null,
    TotalReward             double                             null,
    COAt                    date                               null,
    daysOnPlatform          bigint                             null,
    isRet1                  smallint                           null,
    isRet2                  smallint                           null,
    isRet3                  smallint                           null,
    isRet4                  smallint                           null,
    isRet5                  smallint                           null,
    isRet6                  smallint                           null,
    isRet7                  smallint                           null,
    isRet14                 smallint                           null,
    isRet30                 smallint                           null,
    isRet60                 smallint                           null,
    isRet90                 smallint                           null,
    isAct1                  smallint                           null,
    isAct3                  smallint                           null,
    isAct14                 smallint                           null,
    isAct31                 smallint                           null,
    CPAp                    double                             null,
    DSp                     double                             null,
    LTV180                  double                             null,
    LTV360                  double                             null,
    LTV720                  double                             null,
    createdAt               datetime default CURRENT_TIMESTAMP not null,
    managerBonuses          double                             null,
    managerBonusesWagerDone double                             null,
    isSelfExl               smallint                           null,
    disabled                smallint                           null,
    VIPManager              varchar(255)                       null,
    chargeBack              double                             null,
    trafficType             varchar(255)                       null,
    managerBonusesCount     int                                null,
    additionalDeductionsSum double                             null,
    correctionWithdraw      double                             null,
    isVIPMike               smallint                           null
)
    collate = utf8mb4_unicode_ci;

create table bireport_db.RawCustomerIO
(
    id                bigint unsigned not null
        primary key,
    acceptBonuses     varchar(255)    null,
    confirmedAt       varchar(255)    null,
    country           varchar(255)    null,
    currency          varchar(255)    null,
    dateOfBirth       varchar(255)    null,
    disabled          varchar(255)    null,
    duplicates        varchar(255)    null,
    email             varchar(255)    null,
    firstName         varchar(255)    null,
    gender            varchar(255)    null,
    groupList         longtext        null,
    lastLoginCountry  varchar(255)    null,
    lastName          varchar(255)    null,
    locale            varchar(255)    null,
    receivePromos     varchar(255)    null,
    receiveSmsPromos  varchar(255)    null,
    serverCodename    varchar(255)    null,
    siteDomain        varchar(255)    null,
    subscriptionToken varchar(255)    null,
    tags              longtext        null,
    timezone          varchar(255)    null,
    rawCreatedAt      varchar(255)    null,
    createdAt         datetime        not null,
    updatedAt         datetime        not null,
    stag              varchar(255)    null,
    campaignId        varchar(255)    null,
    externalId        varchar(255)    null,
    phone             varchar(255)    null,
    brandName         varchar(255)    null,
    playerId          bigint          null,
    constraint externalId_idx
        unique (externalId),
    constraint playerId_brandName_idx
        unique (playerId, brandName)
)
    collate = utf8mb4_unicode_ci;

create table bireport_db.VIPModelPrediction
(
    id         bigint unsigned not null
        primary key,
    playerId   varchar(255)    not null,
    predict    double          not null,
    createdAt  datetime        not null,
    updatedAt  datetime        not null,
    playerData json            not null,
    constraint UNIQ_5BC7EF1282E7DC2B
        unique (playerId)
)
    collate = utf8mb4_unicode_ci;

create table bireport_db.ActiveVipUsers
(
    id                  bigint unsigned not null
        primary key,
    uidInCasino         varchar(255)    not null,
    firstVipPeriodStart varchar(255)    null,
    firstVipPeriodEnd   varchar(255)    null,
    lastVipPeriodStart  varchar(255)    null,
    lastVipPeriodEnd    varchar(255)    null,
    septDeps            double          null,
    FTDAt               varchar(255)    not null,
    last30DepSum        double          not null,
    createdAt           datetime        not null,
    updatedAt           datetime        not null,
    constraint UNIQ_CA67799410B5BD33
        unique (uidInCasino)
)
    collate = utf8mb4_unicode_ci;

create table bireport_db.EnteractivePlayerSegmentCheck
(
    BrandName              text charset utf8mb4 null,
    ClientUserId           bigint               null,
    LastDepositDate        date                 null,
    AcceptsTelesalesOffers bigint               null,
    AcceptsSmsOffers       double               null,
    AcceptsEmailOffers     double               null,
    Eligible               bigint               null,
    CreatedAt              date                 null,
    SegmentId              bigint               null,
    SegmentName            text charset utf8mb4 null
)
    collate = utf8mb4_unicode_ci;

create table bireport_db.EnteractivePlayerSegmentFull
(
    id                        int unsigned auto_increment
        primary key,
    BrandName                 varchar(255) null,
    CustomerId                bigint       null,
    AffiliateCode             varchar(255) null,
    FirstName                 varchar(255) null,
    LastName                  varchar(255) null,
    Username                  varchar(255) null,
    Email                     varchar(255) null,
    Phone                     varchar(255) null,
    MobilePhone               varchar(255) null,
    City                      varchar(255) null,
    CountryCode               varchar(255) null,
    RegistrationDate          date         null,
    LastLoginDate             date         null,
    LastDepositDate           date         null,
    FailedDepositDate         date         null,
    CustomerAccountStatus     varchar(255) null,
    Gender                    varchar(255) null,
    MainProduct               varchar(255) null,
    SportsbookTurnover        decimal      null,
    CasinoTurnover            decimal      null,
    PokerRake                 decimal      null,
    LifetimeDepositAmount     decimal      null,
    LifetimeAccountingRevenue decimal      null,
    AcceptsSmsOffers          tinyint(1)   null,
    AcceptsEmailOffers        tinyint(1)   null,
    AcceptsTelesalesOffers    tinyint(1)   null,
    SegmentId                 varchar(255) null,
    SegmentName               varchar(255) null,
    CreatedAt                 date         null
);

create table bireport_db.PlayerRankedMonthlyPy
(
    playerId             bigint   null,
    brandName            text     null,
    NumericSegment       bigint   null,
    InterpSegment        text     null,
    updatedAt            datetime null
);

create table aramuz_db.Segment
(
    id             bigint unsigned not null
        primary key,
    name           varchar(255)    not null,
    filters        json            not null,
    dynamic        tinyint(1)      not null,
    permanent      tinyint(1)      not null,
    manual         tinyint(1)      not null,
    published      tinyint(1)      not null,
    recalculatedAt datetime        not null,
    createdAt      datetime        not null,
    updatedAt      datetime        not null,
    wlId           bigint unsigned not null,
    constraint UNIQ_D73CCCF95E237E06FD052470
        unique (name, wlId)
);

create table aramuz_db.PlayerSegment
(
    id        bigint unsigned not null
        primary key,
    createdAt datetime        not null,
    updatedAt datetime        not null,
    playerId  bigint unsigned not null,
    segmentId bigint unsigned not null,
    constraint UNIQ_271F65182E7DC2BFFE0C202
        unique (playerId, segmentId)
);

create index IDX_271F65182E7DC2B
    on aramuz_db.PlayerSegment (playerId);

create index IDX_271F651FFE0C202
    on aramuz_db.PlayerSegment (segmentId);

create index IDX_D73CCCF9FD052470
    on aramuz_db.Segment (wlId);

create table aramuz_db.Whitelabel
(
    id                                       bigint unsigned                                                                                                                             not null
        primary key,
    name                                     varchar(255)                                                                                                             default ''         not null,
    slug                                     varchar(255)                                                                                                             default ''         not null,
    status                                   enum ('active', 'disabled')                                                                                              default 'disabled' not null comment '(DC2Type:whitelabel_active_enum_type)',
    host                                     varchar(255)                                                                                                             default ''         not null,
    notifyEmail                              varchar(255)                                                                                                             default ''         not null,
    customerioSiteId                         varchar(255)                                                                                                                                null,
    customerioApiKey                         varchar(255)                                                                                                                                null,
    telegramApiBotToken                      varchar(255)                                                                                                                                null,
    telegramApiGumballpayNotificationGroupId varchar(255)                                                                                                                                null,
    fastTrackApiKey                          varchar(255)                                                                                                             default ''         not null,
    liveChatSalt                             varchar(255)                                                                                                                                null,
    smarticoApiKey                           varchar(255)                                                                                                                                null,
    cryptKey                                 varchar(255)                                                                                                             default ''         not null,
    blockedCountryList                       longtext                                                                                                                                    not null comment '(DC2Type:simple_array)',
    jurisdiction                             enum ('MGA', 'UKGC', 'DKSM', 'IGSC', 'LVLG', 'GRA', 'CURE', 'SSI', 'LGCA', 'GERS', 'ADM', 'ONJN', 'HGC', 'GNRS', 'ETCB') default 'CURE'     not null comment '(DC2Type:jurisdiction_enum_type)',
    sessionTimeoutMin                        int                                                                                                                      default 0          not null,
    playerLoginAttemptsLimit                 int                                                                                                                      default 0          not null,
    playerLoginFailTimeoutMinutes            int                                                                                                                      default 0          not null,
    requireEmailConfirm                      tinyint(1)                                                                                                               default 0          not null,
    requiredFieldList                        longtext                                                                                                                                    not null comment '(DC2Type:simple_array)',
    enablePlayerExistentChecking             tinyint(1)                                                                                                               default 0          not null,
    multisessionsEnabled                     tinyint(1)                                                                                                               default 0          not null,
    virtualAccountsEnabled                   tinyint(1)                                                                                                               default 0          not null,
    passwordStrengthSettings                 json                                                                                                                                        not null,
    settlementReportUrl                      varchar(2048)                                                                                                            default ''         not null,
    winnerMinAmount                          int                                                                                                                      default 0          not null,
    chatBotToken                             varchar(255)                                                                                                                                null,
    utorgPublicKey                           longtext                                                                                                                                    null,
    googleAnalyticsApiSecret                 varchar(255)                                                                                                                                null,
    googleAnalyticsMeasurementId             varchar(255)                                                                                                                                null,
    zeroBounceApiKey                         varchar(255)                                                                                                                                null,
    virtualCurrencyList                      longtext                                                                                                                                    null comment '(DC2Type:simple_array)',
    hideCountryList                          longtext                                                                                                                                    null comment '(DC2Type:simple_array)',
    slackNotificationToken                   varchar(255)                                                                                                                                null,
    slackNotificationChannelId               varchar(255)                                                                                                                                null,
    boSessionTimeoutMin                      int                                                                                                                      default 20         not null,
    transactionAutoApproveEnabled            tinyint(1)                                                                                                               default 0          not null,
    s3Config                                 json                                                                                                                                        null,
    bettingEnabled                           tinyint(1)                                                                                                               default 1          not null,
    blacklistApiKey                          varchar(255)                                                                                                                                null,
    createdAt                                datetime                                                                                                                                    not null,
    updatedAt                                datetime                                                                                                                                    not null,
    blacklistId                              bigint unsigned                                                                                                                             null,
    countryIpWhitelist                       longtext                                                                                                                                    null comment '(DC2Type:simple_array)',
    registerDefaultCurrency                  varchar(255)                                                                                                             default 'EUR'      not null,
    playerCustomParamList                    longtext                                                                                                                                    null comment '(DC2Type:simple_array)',
    constraint UNIQ_18C6A04F989D9B62
        unique (slug)
);

create index IDX_18C6A04F9E2B14A5
    on aramuz_db.Whitelabel (blacklistId);

create table bireport_db.PlayerActivityTag
(
    playerId    bigint                             not null,
    brandName   varchar(255)                       not null,
    tagsHistory json                               not null,
    tag         varchar(255)                       not null,
    createdAt   datetime default CURRENT_TIMESTAMP not null
);

create table bireport_db.EarlyLifeTag
(
    playerId  bigint                             not null,
    brandName varchar(255)                       not null,
    tag       varchar(255)                       not null,
    createdAt datetime default CURRENT_TIMESTAMP not null,
    constraint UIDInCasino
        unique (brandName, playerId)
);

create table bireport_db.WithdrawalSpeedTags
(
    playerId  bigint                             not null,
    brandName varchar(255)                       not null,
    TAG       varchar(255)                       not null,
    createdAt datetime default CURRENT_TIMESTAMP not null
);

create table bireport_db.DepositMilestoneTags
(
    playerId  bigint                             not null,
    brandName varchar(255)                       not null,
    2k_Deposit_Milestone_days   varchar(255)     null,
    5k_Deposit_Milestone_days   varchar(255)     null,
    createdAt datetime default CURRENT_TIMESTAMP null
);

create table bireport_db.WinningCustomersTag
(
    playerId  bigint                             not null,
    brandName varchar(255)                       not null,
    tagName varchar(255)     null,
    createdAt datetime default CURRENT_TIMESTAMP null,
    expiredAt datetime default CURRENT_TIMESTAMP null
);

create table bireport_db.LosingCustomersTag
(
    playerId  bigint                             not null,
    brandName varchar(255)                       not null,
    createdAt datetime default CURRENT_TIMESTAMP null,
    ExpirationDate datetime default CURRENT_TIMESTAMP null
);

create table bireport_db.ExpiredTag
(
    playerId  bigint                             not null,
    brandName varchar(255)                       not null,
    tagName varchar(255)     null,
    createdAt datetime default CURRENT_TIMESTAMP null,
    expiredAt datetime default CURRENT_TIMESTAMP null
);

create table bireport_db.BitrixManagerInteractions
(
    id                bigint unsigned not null
        primary key,
    customerId        varchar(255)    not null,
    customerName      varchar(255)    null,
    eventId           varchar(255)    not null,
    interactionMethod varchar(255)    not null,
    vipManager        varchar(255)    not null,
    vipManagerId      varchar(255)    not null,
    sender            varchar(255)    null,
    messageFrom       varchar(255)    null,
    eventTime         datetime        not null,
    createdAt         datetime        not null,
    updatedAt         datetime        not null,
    constraint customerId_eventId_interactionMethod
        unique (customerId, eventId, interactionMethod)
)
    collate = utf8mb4_unicode_ci;

create table bireport_db.BitrixCrmContact
(
    id           bigint unsigned not null
        primary key,
    externalId   varchar(255)    not null,
    emailList    json            null,
    name         varchar(255)    null,
    vipStatus    varchar(255)    null,
    vipGroup     varchar(255)    null,
    contactId    varchar(255)    null,
    brandName    varchar(255)    null,
    lastDepSum   varchar(255)    null,
    lastDepDate  varchar(255)    null,
    createdAt    datetime        not null,
    updatedAt    datetime        not null,
    vipManager   varchar(255)    null,
    vipManagerId varchar(255)    null,
    constraint UNIQ_57DD38BE744BF426
        unique (contactId)
)
    collate = utf8mb4_unicode_ci;

create index externalIdIndex
    on bireport_db.BitrixCrmContact (externalId);

create table bireport_db.playersInfoByEmails
(
    email       varchar(255)                       not null,
    playerId    bigint                             not null,
    source      varchar(255)                       not null,
    brandName   varchar(255)                       not null,
    UIDInCasino varchar(255)                       not null,
    regAt       date                               not null,
    isFTD       bigint,
    ftdAT       date,
    disabled    tinyint                            not null,
    link        varchar(255)                       not null
);

create table bireport_db.PlayerRankedWeeklyPy
(
    unionId              varchar(255) null,
    playerId             bigint       not null,
    brandName            varchar(255) not null,
    partnerId            varchar(255) null,
    partnerName          varchar(255) null,
    firstDepDay          date         null,
    lastDepDay           date         null,
    cntWeekWithDep       bigint       null,
    depSumTotal          double       null,
    AverageDepSumEur     double       null,
    AverageBetSumEur     double       null,
    AverageCashOutSumEur double       null,
    AverageGgrSumEur     double       null,
    AverageNgrSumEur     double       null,
    BonusEffective       double       null,
    NgrHold              double       null,
    WD                   double       null,
    totalKRD             double       null,
    totalKrdPrct         double       null,
    NumericSegment       bigint       null,
    InterpSegment        varchar(255) null,
    lastUpdatedAt        datetime     null,
    NumericSegmentMax    bigint       null,
    InterpSegmentMax     varchar(255) null,
    ABsegment            varchar(255) null,
    updatedAt            datetime     null,
    primary key (playerId, brandName)
)
    collate = utf8mb4_unicode_ci;

insert into bireport_db.PlayerRankedWeeklyPy
(unionId, playerId, brandName, partnerId, partnerName, firstDepDay, lastDepDay, cntWeekWithDep, depSumTotal, AverageDepSumEur, AverageBetSumEur, AverageCashOutSumEur, AverageGgrSumEur, AverageNgrSumEur, BonusEffective, NgrHold, WD, totalKRD, totalKrdPrct, NumericSegment, InterpSegment, lastUpdatedAt, NumericSegmentMax, InterpSegmentMax, updatedAt)
values
    ('brunocasino:222', 45, 'brunocasino','organic', null, '2022-02-28','2022-07-20',2,20,10,27.5,0,9.975,9.975,1,0.9974999999999999,0,1055.8022717614472,0.46,3,'Low', '2022-07-28 03:30:47', 3,'Low', '2022-07-28 03:30:47');

insert into bireport_db.PlayerRankedWeeklyPy
(unionId, playerId, brandName, partnerId, partnerName, firstDepDay, lastDepDay, cntWeekWithDep, depSumTotal, AverageDepSumEur, AverageBetSumEur, AverageCashOutSumEur, AverageGgrSumEur, AverageNgrSumEur, BonusEffective, NgrHold, WD, totalKRD, totalKrdPrct, NumericSegment, InterpSegment, lastUpdatedAt, NumericSegmentMax, InterpSegmentMax, updatedAt)
values
    ('ninecasino:7777', 77, 'ninecasino','organic', null, '2022-02-28','2022-07-20',2,20,10,27.5,0,9.975,9.975,1,0.9974999999999999,0,1055.8022717614472,0.46,3,'Low', '2022-07-28 03:30:47', 3,'Low', '2022-07-28 03:30:47');

insert into bireport_db.PlayerRankedWeeklyPy
(unionId, playerId, brandName, partnerId, partnerName, firstDepDay, lastDepDay, cntWeekWithDep, depSumTotal, AverageDepSumEur, AverageBetSumEur, AverageCashOutSumEur, AverageGgrSumEur, AverageNgrSumEur, BonusEffective, NgrHold, WD, totalKRD, totalKrdPrct, NumericSegment, InterpSegment, lastUpdatedAt, NumericSegmentMax, InterpSegmentMax, updatedAt)
values
    ('octocasino:222', 45, 'octocasino','organic', null, '2022-02-28','2022-07-20',2,20,10,27.5,0,9.975,9.975,1,0.9974999999999999,0,1055.8022717614472,0.46,3,'Low', '2022-07-28 03:30:47', 3,'Low', '2022-07-28 03:30:47');

insert into bireport_db.PlayerRankedMonthlyPy (playerId, brandName, NumericSegment, InterpSegment) values (691633, 'getslots', 6, 'Very High');
insert into bireport_db.PlayerRankedMonthlyPy (playerId, brandName, NumericSegment, InterpSegment) values (248460143466428803, 'ninecasino', 4, 'Medium');
create table bireport_db.VipManagerPlusTagView
(
    playerId  bigint                             not null,
    brandName varchar(255)                       not null,
    tagName   varchar(8)                         not null
);

insert into bireport_db.PlayerRankedMonthlyPy (playerId, brandName, NumericSegment, InterpSegment) VALUES (691633, 'getslots', 6, 'Very High');
insert into bireport_db.PlayerRankedMonthlyPy (playerId, brandName, NumericSegment, InterpSegment) VALUES (248460143466428803, 'ninecasino', 4, 'Medium');

insert into bireport_db.ActiveVipUsers
    (id, uidInCasino, firstVipPeriodStart, firstVipPeriodEnd, lastVipPeriodStart, lastVipPeriodEnd, septDeps, FTDAt, last30DepSum, isSuperVip, createdAt, updatedAt)
values
    (999999999, 'duxcasino:599209', '2021-12-05 00:15:0', '2021-12-12 00:15:0', '2022-02-12 00:15:0', '2022-02-15 00:15:0', null, '2022-02-12 00:15:0', 7069.9998213968, 1, '2021-12-05 00:15:0', '2022-03-20 00:15:0');

insert into aramuz_db.Player
    (id, email, password, country, createdAt, updatedAt, wlId, birthDate, gender, twoFactorSecretKey)
values
    (120446520023388492, 'nora.topalli84@hotmail.de', '123456', 'Germany', '2021-12-05 00:15:0', '2021-12-05 00:15:0', 1234567890, '1984-07-09', 'male', '666665555');

insert into aramuz_db.Player
    (id, email, password, country, createdAt, updatedAt, wlId, birthDate, gender, twoFactorSecretKey)
values
    (329007779327659828, 'kevin.@hotmail.de', '123456', 'Germany', '2022-01-07 15:01:13', '2022-03-11 12:44:1', 1234567892, '1984-07-09', 'male', '66666444444');

insert into aramuz_db.PlayerLimit
    (id, refreshAt, cancelAt, createdAt, updatedAt, playerId, value, currentValue, nextValue, nextValueApplyAt)
values
    (2222222222222, null, null, '2021-12-05 00:15:0', '2021-12-05 00:15:0', 120446520023388492, 500, 300, 400, null);

insert into aramuz_db.PlayerLimit
    (id, refreshAt, cancelAt, createdAt, updatedAt, playerId, value, currentValue, nextValue, nextValueApplyAt)
values
    (6666666666, null, null, '2022-01-07 15:01:13', '2022-03-11 12:44:1', 329007779327659828, 500, 300, 400, null);

insert into aramuz_db.Tag
    (id, object, createdAt, updatedAt, wlId)
values
    (3333333333, 'player', '2021-12-03', '2021-12-03', 1234567890);

insert into aramuz_db.Tag
    (id, object, createdAt, updatedAt, wlId)
values
    (777777777, 'player', '2022-01-07', '2022-01-07', 1234567892);

insert into aramuz_db.TagObject
    (id, objectId, createdAt, updatedAt, tagId)
values
    (44444444, 120446520023388492, '2022-03-03', '2022-03-03', 3333333333);

insert into aramuz_db.TagObject
    (id, objectId, createdAt, updatedAt, tagId)
values
    (8888888888, 329007779327659828, '2022-03-03', '2022-03-03', 777777777);

insert into bireport_db.ClickHouseDashboardDataMartByDate
    (id, date, playerId, affiliatePlayerId, campaignId, source, FTDS, DC, DS, BS, WS, bonuses, GGR, RNGR, gameProviderFee, paymentSystemFee, BC, FTDAt, COS, ADS, isVIP, isM1D, countryName, partnerId, partnerName, manager, managerEmail, brandName, teamId, buyerId, regAt, isReg, isFTD, LBAt, cohFilter, deal, CPA, RS, isBL, BL, CNGRwithVAT, CNGR, CNGRtrue, UIDInCasino, email, phone, firstName, lastName, age, isBef30, isBetw30and39, isBetw40and54, isAft55, isMan, isWmn, gender, birthday, isVIPMax, isVIPTed, isVIPAdele, isVIPLam, isVIPDav, isVIPSandra, isVIPMorris, isVIPLarry, isVIPDaniel, isVIPKevin, isVIPJaha, isVIPAlan, isVIPAnneMarie, VipGroupDate, isQual, Activity, CPAreward, RSreward, TotalReward, COAt, daysOnPlatform, isRet1, isRet2, isRet3, isRet4, isRet5, isRet6, isRet7, isRet14, isRet30, isRet60, isRet90, isAct1, isAct3, isAct14, isAct31, CPAp, DSp, LTV180, LTV360, LTV720, createdAt, managerBonuses, managerBonusesWagerDone, isSelfExl, disabled, VIPManager, chargeBack, trafficType, managerBonusesCount, additionalDeductionsSum, correctionWithdraw, isVIPMike)
values
    (12737, '2022-03-03', 120446520023388492, null, null, 'aramuz', null, null, null, null, null, null, null, null, null, null, null, null, null,null, 0, 0, 'Germany', 35870, 'alfaios', 'syndicateogarasyuta', 'oleggarasuyta@chillipartners.com', 'ninecasino', null, null, '2022-03-03', 1, null, null, '2021-11-15', null, null, null,null,null,null,null,null, 'ninecasino:120446520023388492', 'nora.topalli84@hotmail.de', '+4915168829417', 'Launore', 'Zgheran', 37, 0, 1, 0, 0, 0, 1, 'male', '1984-07-09',  null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2022-03-10 10:15:02', null, null, null, 0, 'None', null, 'affiliate', null, null, null, 0);

insert into bireport_db.ClickHouseDashboardDataMartByDate
    (id, date, playerId, affiliatePlayerId, campaignId, source, FTDS, DC, DS, BS, WS, bonuses, GGR, RNGR, gameProviderFee, paymentSystemFee, BC, FTDAt, COS, ADS, isVIP, isM1D, countryName, partnerId, partnerName, manager, managerEmail, brandName, teamId, buyerId, regAt, isReg, isFTD, LBAt, cohFilter, deal, CPA, RS, isBL, BL, CNGRwithVAT, CNGR, CNGRtrue, UIDInCasino, email, phone, firstName, lastName, age, isBef30, isBetw30and39, isBetw40and54, isAft55, isMan, isWmn, gender, birthday, isVIPMax, isVIPTed, isVIPAdele, isVIPLam, isVIPDav, isVIPSandra, isVIPMorris, isVIPLarry, isVIPDaniel, isVIPKevin, isVIPJaha, isVIPAlan, isVIPAnneMarie, VipGroupDate, isQual, Activity, CPAreward, RSreward, TotalReward, COAt, daysOnPlatform, isRet1, isRet2, isRet3, isRet4, isRet5, isRet6, isRet7, isRet14, isRet30, isRet60, isRet90, isAct1, isAct3, isAct14, isAct31, CPAp, DSp, LTV180, LTV360, LTV720, createdAt, managerBonuses, managerBonusesWagerDone, isSelfExl, disabled, VIPManager, chargeBack, trafficType, managerBonusesCount, additionalDeductionsSum, correctionWithdraw, isVIPMike)
values
    (1874540, '2021-11-29', 599209, 12361594, 170427, 'SS BO', 19.999999552965164, 1, 19.999999552965164, 35.88999919779599, 17.989999597892165, 0, 17.899999599903822, 17.899999599903822, 1.94, 1.03, 133, '2021-11-29', 0, 19.99, 0, 0, 'Germany','103890', 'Cashstorm Creative OU', 'Daniele Cucinotta', 'dcucinotta@chillipartners.com', 'duxcasino', null, null, '2021-11-29', 1, 1, '2021-11-29', '2021-11-29', 'CPA 350 EUR ', 350, 0, 1, 1, null, 8.264429815275594, 13.463599627910554, 'duxcasino:599209', 'johannesfuchs60@gmail.com', '+4915144360788', 'John', 'Travolta', 21, 1, 0, 0, 0, 1, 0, 'm', '2001-02-14', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 , 0, null, 1,55.88999875076115, 350, 0, 350, null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.37, 1099, 1494.26, 1880.18, 2109,'2022-03-10 15:15:02', 0, 0, 0, 0, 'None', 0, 'affiliate', null, 0, null, 0);

insert into bireport_db.ClickHouseDashboardDataMartByDate
    (id, date, playerId, affiliatePlayerId, campaignId, source, FTDS, DC, DS, BS, WS, bonuses, GGR, RNGR, gameProviderFee, paymentSystemFee, BC, FTDAt, COS, ADS, isVIP, isM1D, countryName, partnerId, partnerName, manager, managerEmail, brandName, teamId, buyerId, regAt, isReg, isFTD, LBAt, cohFilter, deal, CPA, RS, isBL, BL, CNGRwithVAT, CNGR, CNGRtrue, UIDInCasino, email, phone, firstName, lastName, age, isBef30, isBetw30and39, isBetw40and54, isAft55, isMan, isWmn, gender, birthday, isVIPMax, isVIPTed, isVIPAdele, isVIPLam, isVIPDav, isVIPSandra, isVIPMorris, isVIPLarry, isVIPDaniel, isVIPKevin, isVIPJaha, isVIPAlan, isVIPAnneMarie, VipGroupDate, isQual, Activity, CPAreward, RSreward, TotalReward, COAt, daysOnPlatform, isRet1, isRet2, isRet3, isRet4, isRet5, isRet6, isRet7, isRet14, isRet30, isRet60, isRet90, isAct1, isAct3, isAct14, isAct31, CPAp, DSp, LTV180, LTV360, LTV720, createdAt, managerBonuses, managerBonusesWagerDone, isSelfExl, disabled, VIPManager, chargeBack, trafficType, managerBonusesCount, additionalDeductionsSum, correctionWithdraw, isVIPMike)
values
    (12738, '2022-03-03', 329007779327659828, null, null, 'aramuz', null, null, 7000, null, null, null, null, null, null, null, null, null, 1000,null, 0, 0, 'Germany', 35870, 'alfaios', 'syndicateogarasyuta', 'oleggarasuyta@chillipartners.com', 'brunocasino', null, null, '2022-03-03', 1, null, null, '2021-11-15', null, null, null,null,null,null,null,null, 'brunocasino:329007779327659828', 'kevin.@hotmail.de', '+4915168829417', 'Kevin', 'Cochran', 37, 0, 1, 0, 0, 0, 1, 'male', '1984-07-09',  null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0, null, null, null,null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2022-03-10 10:15:02', null, null, null, 0, 'None', null, 'affiliate', null, null, null, 0);

insert into bireport_db.VIPModelPrediction
    (id, playerId, predict, createdAt, updatedAt, playerData)
values
    (55555555, 'ninecasino:120446520023388492', 0, '2021-12-05 00:15:05', '2021-12-05 23:15:06', '{"BC": 48, "BS": 58, "DC": 1, "DS": 15, "WS": 28, "Age": 37, "CNGR": 8.7, "FDDS": 15, "Gender": "female", "userID": "ninecasino:120446520023388492", "country": "Germany", "brandName": "ninecasino", "partnerId": "35870", "bonusesSum": 15, "trafficType": "affiliate"}');

insert into bireport_db.VIPModelPrediction
    (id, playerId, predict, createdAt, updatedAt, playerData)
values
    (3368251689341771, 'duxcasino:599209', 0, '2021-12-05 00:15:05', '2021-12-05 23:15:06', '{"BC": 133, "BS": 35.89, "DC": 1, "DS": 20, "WS": 17.99, "Age": 20, "CNGR": 10.2, "FDDS": 0, "Gender": "m", "userID": "duxcasino:599209", "country": "Germany", "brandName": "duxcasino", "partnerId": "103890", "bonusesSum": 0, "trafficType": "affiliate"}');

insert into bireport_db.VIPModelPrediction
    (id, playerId, predict, createdAt, updatedAt, playerData)
values
    (3368251689341772, 'brunocasino:329007779327659828', 0, '2022-01-07 15:01:13', '2022-01-07 15:01:13', '{"BC": 133, "BS": 35.89, "DC": 1, "DS": 20, "WS": 17.99, "Age": 27, "CNGR": 10.2, "FDDS": 0, "Gender": "m", "userID": "brunocasino:329007779327659828", "country": "Germany", "brandName": "duxcasino", "partnerId": "103890", "bonusesSum": 0, "trafficType": "affiliate"}');

insert into bireport_db.RawCustomerIO
    (id, acceptBonuses, confirmedAt, country, currency, dateOfBirth, disabled, duplicates, email, firstName, gender, groupList, lastLoginCountry, lastName, locale, receivePromos, receiveSmsPromos, serverCodename, siteDomain, subscriptionToken, tags, timezone, rawCreatedAt, createdAt, updatedAt, stag, campaignId, externalId, phone, brandName, playerId)
values
    (251287737383534638,'false', 0, 'DE', 'EUR', 982108800, 'none', 'false', 'johannesfuchs60@gmail.com', 'John', 'm', '["00057","00062","00102","00427","00014","00100","00103","00133","00375","00362","00268","00152","00017","00101","00060","00426","00022","00161","00272","00183","00361"]', 'DE', 'Travolta', 'de', 'false', 'false', 'duxcasino', 'www.duxcasino.com', 'f9a9d5b26082d350f223325cfd141ed12f574f4bd29da026d3abaa2f5d50351f','[]', 'Etc/UTC', '1638158644', '2021-11-29 08:00:25', '2022-03-10 15:57:01', '103890_61a450bf8c6f94ea7984ed45', '103890', 'duxcasino:599209', '+4915144360788', 'duxcasino', 599209);

insert into bireport_db.EnteractivePlayerSegmentCheck
    (BrandName, ClientUserId, LastDepositDate, AcceptsTelesalesOffers, AcceptsSmsOffers, AcceptsEmailOffers, Eligible, CreatedAt, SegmentId, SegmentName)
values
   ('duxcasino', 99999999, '2021-08-27', 0, 0, 0, 0, '2022-03-28', 432, 'seg2 enteractive (last deposit before 15.12.21)');

insert into bireport_db.EnteractivePlayerSegmentCheck
    (BrandName, ClientUserId, LastDepositDate, AcceptsTelesalesOffers, AcceptsSmsOffers, AcceptsEmailOffers, Eligible, CreatedAt, SegmentId, SegmentName)
values
    ('brunocasino', 555555555, '2021-08-27', 0, 0, 0, 0, '2022-03-28', 432, 'seg2 enteractive (last deposit before 15.12.21)');

insert into bireport_db.EnteractivePlayerSegmentFull
    (id, BrandName, CustomerId, AffiliateCode, FirstName, LastName, Username, Email, Phone, MobilePhone, City, CountryCode, RegistrationDate, LastLoginDate, LastDepositDate, FailedDepositDate, CustomerAccountStatus, Gender, MainProduct, SportsbookTurnover, CasinoTurnover, PokerRake, LifetimeDepositAmount, LifetimeAccountingRevenue, AcceptsSmsOffers, AcceptsEmailOffers, AcceptsTelesalesOffers, SegmentId, SegmentName, CreatedAt)
values
    (9, 'duxcasino', 99999999, '88081', 'Jack', 'Jackson', 'JJ', 'tp@gmail.com', null, '+17809069695', 'Edmonton', 'CA', '2021-01-11', null, '2021-08-27', null, null, 'm', null, null, 602, null, 40, 40, 0, 0, 0, '432', 'seg2 enteractive (last deposit before 15.12.21) ','2022-03-21');

insert into bireport_db.EnteractivePlayerSegmentFull
    (id, BrandName, CustomerId, AffiliateCode, FirstName, LastName, Username, Email, Phone, MobilePhone, City, CountryCode, RegistrationDate, LastLoginDate, LastDepositDate, FailedDepositDate, CustomerAccountStatus, Gender, MainProduct, SportsbookTurnover, CasinoTurnover, PokerRake, LifetimeDepositAmount, LifetimeAccountingRevenue, AcceptsSmsOffers, AcceptsEmailOffers, AcceptsTelesalesOffers, SegmentId, SegmentName, CreatedAt)
values
    (10, 'brunocasino', 555555555, '88081', 'John', 'Smith', 'JSM', 'tp2@gmail.com', null, '+17809069695', 'Edmonton', 'CA', '2021-01-11', null, '2021-08-27', null, null, 'm', null, null, 602, null, 40, 40, 0, 0, 0, '432', 'seg2 enteractive (last deposit before 15.12.21) ','2022-03-21');

insert into aramuz_db.Segment
    (id, name, filters, dynamic, permanent, manual, published, recalculatedAt, createdAt, updatedAt, wlId)
values (267879821472802087, 'seg1 bitrix', '{"betsCount": {"max": 0, "min": 0, "period": {"value": 1, "periodType": "days"}}, "bonusRatio": {"max": 30.2, "min": 10.4}, "receiveSms": true, "registered": {"value": 1, "periodType": "month"}, "enabledUser": true, "depositsCount": {"max": 4, "min": 0, "period": {"value": 1, "periodType": "days"}}, "autoIssueBonuses": true, "depositExistence": {"period": {"value": 1, "periodType": "days"}, "condition": "or", "currencyList": [{"min": 1100, "currency": "USD"}, {"max": 1000, "currency": "EUR"}]}, "depositsAmountSum": {"period": {"value": 1, "periodType": "days"}, "condition": "or", "currencyList": [{"min": 1, "currency": "USD"}, {"max": 2500, "currency": "EUR"}]}, "profileCountryList": [{"excluded": {"list": ["US", "SE"], "condition": "or"}, "included": {"list": ["RU"], "condition": "or"}}], "receiveEmailPromos": true}', 0, 0, 0, 0, '2022-04-19 15:23:24', '2022-04-19 15:23:24', '2022-04-19 15:23:24', '1234567890');

insert into aramuz_db.Segment
    (id, name, filters, dynamic, permanent, manual, published, recalculatedAt, createdAt, updatedAt, wlId)
values
    (319139821124814910, 'seg0 bitrix', '{"betsCount": {"max": 0, "min": 0, "period": {"value": 1, "periodType": "days"}}, "bonusRatio": {"max": 30.2, "min": 10.4}, "receiveSms": true, "registered": {"value": 1, "periodType": "month"}, "enabledUser": true, "depositsCount": {"max": 4, "min": 0, "period": {"value": 1, "periodType": "days"}}, "autoIssueBonuses": true, "depositExistence": {"period": {"value": 1, "periodType": "days"}, "condition": "or", "currencyList": [{"min": 1100, "currency": "USD"}, {"max": 1000, "currency": "EUR"}]}, "depositsAmountSum": {"period": {"value": 1, "periodType": "days"}, "condition": "or", "currencyList": [{"min": 1, "currency": "USD"}, {"max": 2500, "currency": "EUR"}]}, "profileCountryList": [{"excluded": {"list": ["US", "SE"], "condition": "or"}, "included": {"list": ["RU"], "condition": "or"}}], "receiveEmailPromos": true}', 0, 0, 0, 0, '2022-04-19 15:23:24', '2022-04-19 15:23:24', '2022-04-19 15:23:24', '1234567890');

insert into aramuz_db.PlayerSegment
    (id, createdAt, updatedAt, playerId, segmentId)
values
    (125341253170125312, '2022-04-19 15:23:26', '2022-04-19 15:23:26', 120446520023388492, 267879821472802087);

insert into aramuz_db.PlayerSegment
    (id, createdAt, updatedAt, playerId, segmentId)
values
    (444391028170125321, '2022-04-19 15:23:26', '2022-04-19 15:23:26', 329007779327659828, 319139821124814910);

insert into aramuz_db.Whitelabel
    (id, name, slug, status, host, notifyEmail, customerioSiteId, customerioApiKey, telegramApiBotToken, telegramApiGumballpayNotificationGroupId, fastTrackApiKey, liveChatSalt, smarticoApiKey, cryptKey, blockedCountryList, jurisdiction, sessionTimeoutMin, playerLoginAttemptsLimit, playerLoginFailTimeoutMinutes, requireEmailConfirm, requiredFieldList, enablePlayerExistentChecking, multisessionsEnabled, virtualAccountsEnabled, passwordStrengthSettings, winnerMinAmount, boSessionTimeoutMin, transactionAutoApproveEnabled, bettingEnabled, blacklistApiKey, createdAt, updatedAt, registerDefaultCurrency)
values
   (1234567890, 'ninecasino', 'ninecasino', 'active', 'aramuz.docker', 'info@aramuz.docker', null, null, null, null, 'FAKE_API_KEY', 'FAKE_SALT', 'FAKE_API_KEY', 'YjkzYWJhMzBhOTdjZGRkMzM3OTBiNDU1YTE5ZTExNDUwMTMzMGUyMDJjODIzMzRjMTU5ZjNmNjc2NjJhZTAzNjowYTMwZTI1ZGNhZTI1ZmY4YWRjNDBmNGQwZDQwOWM', 'RU,UA,KZ', 'CURE', 20, 0, 0, 0, 'email,password,country', 0, 0, 0, '{"maxLength": 0, "minLength": 0, "needNumbers": false, "needSymbols": false, "needDifferentCaseCharacters": false}', 500000, 20, 0, 1, 'FAKE_API_KEY', '2022-04-15 12:34:49', '2022-04-15 12:34:49', 'EUR');

insert into bireport_db.PlayerActivityTag
(playerId, brandName, tagsHistory, tag, createdAt)
values
    (911099685706360865, 'ninecasino', '{"activity_NDC": {"value": 1, "periodType": "month"}}', 'Churn', '2021-06-04 10:15:00');

insert into bireport_db.PlayerActivityTag
(playerId, brandName, tagsHistory, tag, createdAt)
values
    (251096681747420893, 'ninecasino', '{"activity_Inactive": {"value": 2, "periodType": "month"}}', 'Retained', '2021-06-04 10:15:00');

insert into bireport_db.EarlyLifeTag
(playerId, brandName, tag, createdAt)
values
    (251096681747420893, 'ninecasino', 'High Prospect', '2021-06-04 14:00:00');

insert into bireport_db.EarlyLifeTag
(playerId, brandName, tag, createdAt)
values
    (911099685706360865, 'ninecasino', 'VIP Prospect', '2021-06-04 12:00:00');

insert into bireport_db.WithdrawalSpeedTags
(playerId, brandName, TAG, createdAt)
values
    (251096681747420893, 'ninecasino', 'Delayed', '2021-06-04 14:00:00');

insert into bireport_db.WithdrawalSpeedTags
(playerId, brandName, TAG, createdAt)
values
    (911099685706360865, 'ninecasino', 'Normal', '2021-06-04 09:00:00');

insert into bireport_db.DepositMilestoneTags
(playerId, brandName, `2k_Deposit_Milestone_days`, `5k_Deposit_Milestone_days`, createdAt)
values
    (911099685706360865, 'ninecasino', 10, null, '2021-06-04 12:00:00');

insert into bireport_db.DepositMilestoneTags
(playerId, brandName, `2k_Deposit_Milestone_days`, `5k_Deposit_Milestone_days`, createdAt)
values
    (911099685706360865, 'ninecasino', null, 11, '2021-06-04 12:00:00');

insert into bireport_db.DepositMilestoneTags
(playerId, brandName, `2k_Deposit_Milestone_days`, `5k_Deposit_Milestone_days`, createdAt)
values
    (911099685706360865, 'ninecasino', 12, 13, '2021-06-04 12:00:00');

insert into bireport_db.WinningCustomersTag
(playerId, brandName, TagName, createdAt, expiredAt)
values
    (251096681747420893, 'ninecasino', 'Winning Customers 1', '2021-06-04 12:00:00', '2021-06-04 12:00:00');

insert into bireport_db.ExpiredTag
(playerId, brandName, TagName, createdAt, expiredAt)
values
    (251096681747420893, 'ninecasino', 'Winning Customers 2', '2021-06-04 12:00:00', '2021-06-04 12:00:00');

insert into bireport_db.WinningCustomersTag
(playerId, brandName, TagName, createdAt, expiredAt)
values
    (251096681747420893, 'ninecasino', 'Winning Customers 2', '2021-06-04 12:00:00', '2023-06-04 12:00:00');

insert into bireport_db.LosingCustomersTag
(playerId, brandName, createdAt, ExpirationDate)
values
    (251096681747420893, 'ninecasino',  '2021-06-04 12:00:00', '2023-06-04 12:00:00');

insert into bireport_db.LosingCustomersTag
(playerId, brandName, createdAt, ExpirationDate)
values
    (251096681747420893, 'ninecasino',  '2021-06-04 12:00:00', '2021-06-24 12:00:00');

insert into bireport_db.BitrixManagerInteractions
(id, customerId, customerName, eventId, interactionMethod, vipManager, vipManagerId, sender, messageFrom, eventTime, createdAt, updatedAt)
values
    (13230045335673513, '19393', 'octocasino:25777 Natascha', '1647755', 'whatsapp', 'antrei', '77', 'antrei', 'manager', '2022-04-13 15:12:29', '2022-04-14 04:30:02', '2022-04-14 04:30:02');

insert into bireport_db.BitrixCrmContact
(id, externalId, emailList, name,  vipManagerId, vipGroup, contactId, brandName, lastDepSum, lastDepDate, createdAt, updatedAt)
values
    (9560345456829939, '19393','[{"id": "47065", "email": "twanvries4@gmail.com"}]','octocasino:25777 Twan', '77', null, 'octocasino:25777', 'octocasino', '20', '2022-04-29', '2022-05-11 12:00:32', '2022-05-11 12:00:32');

insert into bireport_db.playersInfoByEmails
(email, playerId, source, brandName, UIDInCasino, regAt, isFTD, ftdAt, disabled, link)
values
('test1@gmail.com', 1213141516, 'aramuz', 'ninecasino', 'ninecasino:1213141516', '2022-05-02', null, null, 0, 'https://backoffice.ninecasino.com/player/1213141516/info'),
('test2@gmail.com', 1112131415, 'aramuz', 'brunocasino', 'brunocasino:1112131415', '2022-05-02', null, null, 0, 'https://backoffice.brunocasino.com/player/1112131415/info'),
('test3@gmail.com', 1314151617, 'softswiss', 'pinocasino', 'pinocasino:1314151617', '2022-05-02', null, null, 0, 'https://backoffice.pinocasino.com/player/1314151617/info'),
('test4@gmail.com', 1415161718, 'softswiss', 'duxocasino', 'duxocasino:1415161718', '2022-05-02', null, null, 0, 'https://backoffice.duxocasino.com/player/1415161718/info'),
('test5@gmail.com', 1516171819, 'softswiss', 'octocasino', 'octocasino:1516171819', '2022-05-02', null, null, 0, 'https://backoffice.octocasino.com/player/1516171819/info');

insert into bireport_db.VipManagerPlusTagView
(playerId, brandName, tagName)
values
    (251096681747420893, 'ninecasino', 'Manager+');

insert into bireport_db.VipManagerPlusTagView
(playerId, brandName, tagName)
values
    (124422213085747699, 'ninecasino', 'Manager+');

insert into bireport_db.VipManagerPlusTagView
(playerId, brandName, tagName)
values
    (147113, 'duxcasino', 'Manager+');
