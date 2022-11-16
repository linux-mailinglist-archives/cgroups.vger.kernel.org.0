Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9607C62CF3C
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 00:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKPX6m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Nov 2022 18:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKPX6j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Nov 2022 18:58:39 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE6D12778
        for <cgroups@vger.kernel.org>; Wed, 16 Nov 2022 15:58:37 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j12so44267plj.5
        for <cgroups@vger.kernel.org>; Wed, 16 Nov 2022 15:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kojRkknuzQaruikj1Bw1AgCPwluH/lc+Fu21L+WOJJc=;
        b=RwvO8tezPJW+rHCmdRbQ+mADp1YnOCxf4exyMImXeZ746yvzytYOZgond8mRARU4tL
         pQ0qeYVAciS4yBF7nk1nbOofVyL4B0d4vDYyWLrCKCqfEo7QbjYmVUIae6tmOGUCGZRX
         fBpiXhZ1Dwi9HbTy3EYf8cIC4PNO85VbxGM3vhCGU8/Ag91kGCbRgGflI5IITZxfo1/2
         ZJMk2wHlXJVUeD46A9eZFQaUKXVCSIiP4XB44lA7MDEobMur/ZeYiUenuLAulsMFYKz3
         RbUnHNs3xlJr6g0xMtTRbBgwgAl36Yar5dWjaYRwWoPQqagB5508qtDcaTqP1yrdGiQQ
         E9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kojRkknuzQaruikj1Bw1AgCPwluH/lc+Fu21L+WOJJc=;
        b=0ATewkWIcggXsI1SxpdFhl6WlNPHyFsDWSzmay35LszIdIKJL5d7wOsUWzHneqoJCk
         FAI224wmZTOtA2AS0whA2+C/xN59lsCYHP5aG9cZtpGU5hdDKkxvKylRwpg/cnLXb6uu
         VwLlFc+I8sOW7vrU3l1GtJ9UMF0SOUonsOl10D3GFne8kvynGmsWzqqlhEu6389u1mng
         20TcOsRmICDzltZXYZjgNC4dstUaJu97tYWvUDbuSPhG8PDloS41Maqye2xSVP6GbTSK
         kZWGLZu1cRuXprrtDFnKrpDRb5Ab9eUbrtDdI5+/Ei95zl10dUazVIOPIKmEFDqT0HWg
         Tu/w==
X-Gm-Message-State: ANoB5pm4ZajVmkyV6q9jywRVQBTF7CIEjtxsgcCOHR5lrnVVMMAYKP5Y
        7k/uG1bv/GmpHncoykNgGLOzrA==
X-Google-Smtp-Source: AA0mqf6NGk2RuTo6aGaFr95auX8C3f+sgHmdR9BqJEXf7pgDbmWsgSj2ySTo9oGGDAcTDjfogAu8kQ==
X-Received: by 2002:a17:90b:d13:b0:217:ecbd:5ae with SMTP id n19-20020a17090b0d1300b00217ecbd05aemr5831869pjz.17.1668643116857;
        Wed, 16 Nov 2022 15:58:36 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nh9-20020a17090b364900b00212d9a06edcsm2173613pjb.42.2022.11.16.15.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 15:58:36 -0800 (PST)
Message-ID: <5e885fce-a0b4-559f-5498-4402080f6a2e@kernel.dk>
Date:   Wed, 16 Nov 2022 16:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v10 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
References: <20221105005902.407297-1-longman@redhat.com>
 <4b5142be-6a47-9dfd-a238-5b9d29b296b8@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4b5142be-6a47-9dfd-a238-5b9d29b296b8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/16/22 4:06 PM, Waiman Long wrote:
> On 11/4/22 20:58, Waiman Long wrote:
>> ? v10:
>> ?? - Update patch 3 to rename the rstat function to
>> ???? cgroup_rstat_css_cpu_flush().
>>
>> ? v9:
>> ?? - Remove patch "llist: Allow optional sentinel node terminated lockless
>> ???? list" for now. This will be done as a follow-up patch.
>> ?? - Add a new lqueued field to blkg_iostat_set to store the status of
>> ???? whether lnode is in a lockless list.
>> ?? - Add a new patch 3 to speed up the freeing of blkcg by flushing out
>> ???? the rstat lockless lists at blkcg offline time.
>>
>> ? v8:
>> ?? - Update the llist patch to make existing llist functions and macros
>> ???? work for both NULL and sentinel terminated lockless list as much
>> ???? as possible and leave only the initialization and removal functions
>> ???? to have a sentinel terminated llist variants.
>>
>> This patch series improves blkcg_rstat_flush() performance by eliminating
>> unnecessary blkg enumeration and flush operations for those blkg's and
>> blkg_iostat_set's that haven't been updated since the last flush.
>>
>> Waiman Long (3):
>> ?? blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
>> ?? blk-cgroup: Optimize blkcg_rstat_flush()
>> ?? blk-cgroup: Flush stats at blkgs destruction path
>>
>> ? block/blk-cgroup.c???? | 103 +++++++++++++++++++++++++++++++++++------
>> ? block/blk-cgroup.h???? |? 10 ++++
>> ? include/linux/cgroup.h |?? 1 +
>> ? kernel/cgroup/rstat.c? |? 20 ++++++++
>> ? 4 files changed, 119 insertions(+), 15 deletions(-)
> 
> Jens, do you have any further comment on this patchset? Is it possible
> to queue it for the next Linux version?

Looks good to me, I'll queue it up.

-- 
Jens Axboe
