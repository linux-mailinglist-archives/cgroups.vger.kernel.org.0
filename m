Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A548E79772C
	for <lists+cgroups@lfdr.de>; Thu,  7 Sep 2023 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjIGQWO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Sep 2023 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbjIGQVv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Sep 2023 12:21:51 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A5F7DB4;
        Thu,  7 Sep 2023 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694103549; x=1725639549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YauVF01CGBBHBYehJqzxf4f2JW+5DIf+1r8++cg5PLM=;
  b=P3QAX8zLOfeNlSVYnBk8O4LKH1ZDrrYYpF7e5PWyUIqFknEMHKC+gYga
   X84diM7Dk2gbtoCGXb6REJd4vyV+MHnc34nVKwcSA65wAwYGeBDizqPML
   1Vcv/VNfXx/WGrSyHxxdk9memcIdxNSV4jeJi4m2QchDIFctqwQm09Pkz
   4=;
X-IronPort-AV: E=Sophos;i="6.02,235,1688428800"; 
   d="scan'208";a="362200815"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 15:17:01 +0000
Received: from EX19MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id DB24460DBE;
        Thu,  7 Sep 2023 15:17:00 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 7 Sep 2023 15:16:45 +0000
Received: from [192.168.204.203] (10.252.141.11) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 7 Sep 2023 15:16:44 +0000
Message-ID: <236f84be-26b0-758d-3d3f-380e536f72c2@amazon.com>
Date:   Thu, 7 Sep 2023 11:16:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <longman@redhat.com>, <lcapitulino@gmail.com>
References: <20230906005712.66461-1-luizcap@amazon.com>
 <lqcl5cblo3s45afvtgqjkbz2an3zwccsckglhpe3ufyffqavjk@ui45m6itz4ne>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <lqcl5cblo3s45afvtgqjkbz2an3zwccsckglhpe3ufyffqavjk@ui45m6itz4ne>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.141.11]
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
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



On 2023-09-07 11:06, Michal Koutný wrote:
> On Wed, Sep 06, 2023 at 12:57:12AM +0000, Luiz Capitulino <luizcap@amazon.com> wrote:
>> We have a need of using favordynmods with cgroup v1, which doesn't support
>> changing mount flags during remount. Enabling CONFIG_FAVOR_DYNMODS at
>> build-time is not an option because we want to be able to selectively
>> enable it for certain systems.
> 
> Could this be implemented by a utility that would read /proc/cmdline
> (while kernel ignores the arg) and remount respective hierarchies
> accordingly? Or what do I miss?

Yeah, this works for cgroup v2 but my understanding is that cgroup v1
doesn't support changing flags in remount, take a look at
cgroup1_reconfigure().

- Luiz
