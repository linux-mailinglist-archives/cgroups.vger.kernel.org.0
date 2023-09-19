Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7773E7A658C
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjISNnU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjISNnE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 09:43:04 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362631718;
        Tue, 19 Sep 2023 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695130953; x=1726666953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LIiuvlEVoOet9vLgXao/ZPcDivQLZo5gFmYPlTZNxJs=;
  b=GgttyW37o5FMspK0IG1bWyzuQaIH4OpVLD4XVpEUcp/NXWYuxxrcLoof
   GBMWJtt85jMfcmenYOKlGcLDhgz1+IUlG3mL7AnDLhxGYn2i2CMpV7Rgf
   O+2sJOG/BAO50oA6ca+EOxRkFpvqOe3K6H0CFVsZztaH5BgqLO8Jg8iGf
   Y=;
X-IronPort-AV: E=Sophos;i="6.02,159,1688428800"; 
   d="scan'208";a="239593278"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 13:42:28 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id ECD2540D54;
        Tue, 19 Sep 2023 13:42:27 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 19 Sep 2023 13:42:27 +0000
Received: from [192.168.5.95] (10.106.179.18) by EX19D028UEC003.ant.amazon.com
 (10.252.137.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 19 Sep
 2023 13:42:25 +0000
Message-ID: <55e64e7a-5783-94ce-a9fc-1979587c755f@amazon.com>
Date:   Tue, 19 Sep 2023 09:42:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
CC:     <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <longman@redhat.com>, <lcapitulino@gmail.com>
References: <20230906005712.66461-1-luizcap@amazon.com>
 <29bdb453-c6e3-a047-1f27-e9656da92301@amazon.com>
 <ZQiNIWQe7spOwjil@slm.duckdns.org>
 <7zv7lqkondaacjhmc7oscyqzwugguxvjw2yhdhkv4axhhkts7a@upoxgl3qpunt>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <7zv7lqkondaacjhmc7oscyqzwugguxvjw2yhdhkv4axhhkts7a@upoxgl3qpunt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.179.18]
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023-09-19 07:00, Michal Koutný wrote:
> On Mon, Sep 18, 2023 at 07:47:13AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> Michal raised some valid concerns. I don't really mind that it's not great
>> on the edges tho. Michal, what do you think?
> 
> I'd have a few suggestions:
> - reset to have_dynmods value instead of false in cgroup_destroy_root()
>    (to the benefing of the users of this option, not the common default
>    users) or not touch the value in cgroup_destroy_root() at all
> - s/CONFIG_FAVOR_DYNMODS/CONFIG_CGROUP_FAVOR_DYNMODS/ in commit message

Thank you for the detailed suggestions, Michal. I'll on this for v3.

- Luiz
