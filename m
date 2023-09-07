Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A56797C70
	for <lists+cgroups@lfdr.de>; Thu,  7 Sep 2023 20:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjIGS5w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Sep 2023 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344128AbjIGS5v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Sep 2023 14:57:51 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9B92;
        Thu,  7 Sep 2023 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694113068; x=1725649068;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hArgUTfo4A9QwEbpAp+HoDaLEQZ6wVWaKg9DCKFFPXs=;
  b=q4eBNGu1zff93Bn8n/joKncrj+0PbN9h7DSwb2I20qlzwj48dK8w8wS4
   sYx7gZGLA/Wy63LaK2uMvsRnwtGXEte40a+yhVg06oOIrrELWtCKSK7KN
   LShaUNkUBTeEaJIMBJZbBx6etiApJVgJ2edmvRv5+TbZxQzxCTuvWB1eo
   0=;
X-IronPort-AV: E=Sophos;i="6.02,235,1688428800"; 
   d="scan'208";a="303471414"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 18:57:40 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 77DEAA0E9D;
        Thu,  7 Sep 2023 18:57:38 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 7 Sep 2023 18:57:38 +0000
Received: from [192.168.204.203] (10.252.141.11) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 7 Sep 2023 18:57:36 +0000
Message-ID: <542553d6-5e52-5d2a-66db-9c3b409de01b@amazon.com>
Date:   Thu, 7 Sep 2023 14:57:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Luiz Capitulino <luizcap@amazon.com>
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <longman@redhat.com>, <lcapitulino@gmail.com>
References: <20230906005712.66461-1-luizcap@amazon.com>
 <lqcl5cblo3s45afvtgqjkbz2an3zwccsckglhpe3ufyffqavjk@ui45m6itz4ne>
 <236f84be-26b0-758d-3d3f-380e536f72c2@amazon.com>
 <zqgnootbsjyj7wq5ayiallz4m2bz7ad6w67t24peglhc5v6ern@4pfqlshgpnie>
Content-Language: en-US
In-Reply-To: <zqgnootbsjyj7wq5ayiallz4m2bz7ad6w67t24peglhc5v6ern@4pfqlshgpnie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.141.11]
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Resending, looks like I'm having issues with my mail server]

On 2023-09-07 11:57, Michal Koutný wrote:
> On Thu, Sep 07, 2023 at 11:16:41AM -0400, Luiz Capitulino <luizcap@amazon.com> wrote:
>> Yeah, this works for cgroup v2 but my understanding is that cgroup v1
>> doesn't support changing flags in remount, take a look at
>> cgroup1_reconfigure().
> 
> Ah, didn't notice.
> Alhtough -- there seems to be a deeper issue -- the mount option doesn't
> have a per-root semantics. There is only a single
> cgroup_threadgroup_rwsem afterall.
> 
> Even with your cmdline option, you may loose the behavior after
> unmounting any of the v1 hierarchies (cgroup_destroy_root()
> unconditionally disables it).

Good point. I haven't checked this in detail yet, but if
CONFIG_CGROUP_FAVOR_DYNMODS has the same behavior then I wouldn't worry
much about this. Also, I don't know how common it is to unmount and
mount a cgroup hierarchies (if it's not so common then it's even
less important).

We could also investigate on how to make the flag stick as a follow
up work on this.

> 
> Or you could still achieve the result by mounting cgroup2 hierarchy with
> favordynmods. (And unmount it, default root is not ever released.)
> 
> Maybe it would be the best to have this controllable only via v2
> hierarchy (as it's the only documented).
> (And maybe v1s should not show the option at all.)

The main motivation for this patch is really v1 since we can
simply remount v2 with favordynmods enabled (although we do
find this very useful for v2 as well).

Another crazy idea (based on your suggestion to allow only this
controllable in v2), would be to make favordynmods enabled by
default in v1 w/ the rationale that new behavior changes affect
only v2.

- Luiz
