Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4266D15C6
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 05:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCaDBJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 23:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCaDBG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 23:01:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4E1204C
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 20:00:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso24001408pjb.3
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680231639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMrP2Zp/EKlqbziL+FgCOqPjH/auJOar/Bw7xvN0IJw=;
        b=gFLNd4ejWBxSDzU4aEgXUTu5XK7W5N8DYIf8y981jAiIl1PPhf0gQNwn/L7fY8o8Md
         GzCyVbfJEEy/JWxGYXiht+V4N/+fmTClBVFIuAb6szfd5tNfLkYBw1YNTx2czLm2sI/4
         LcWKYMZvb5xYSRjGmgeCQ85FAdWUc+Df9EGS63HjvDKh3crs1/lOjOR7uTf5jUjUrq5k
         cPnJx6PMlORh0s/D/pBuw61Y2/NN+GOsJ2tQ5p/TrXz7Y/mQIXZHi8xi5J/D+mhr1SvN
         iFKRECz2VC/NXpimQsG6Sf6YMmLfu9tL7zZkXzQAYPPhdz5i+P15KxHZ50QexXZjWeLk
         DgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680231639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMrP2Zp/EKlqbziL+FgCOqPjH/auJOar/Bw7xvN0IJw=;
        b=wF8iJf6TayCo+JlOySibh5g7rYJmghR7ksnOFPMqfsZh6uXHjb+zUIXbFsV9wKRKqg
         VrkH1jlhTiR3IA7HMzEDTdYKQTcVIgqmQJXgsaxohu4YLTq8TW3T4li7acpm3yZjw1ru
         GlJYP7X32OwmtY8AitJ5m/pZ4KIxryvWo2MAiWIfN9zM8MfFh8JLfUrQyM8l2PzC71nx
         lDvZszUDd4pwGiRlH4iWRikbd3dBN4M0ZHsbKyaJMmRhFRhWRB4NzlKgMExuoIslVn9O
         ezmMEhD4VcFiTqUcPnS0QGXv9THVH/aSzmiXPV0V5xUMX803aALZvxF7bgYNMEFH01SQ
         pCVQ==
X-Gm-Message-State: AAQBX9c1CmCACWGs5MZRfm3Eyeyzf13GWjuA3moHgSF4DoWeypdoLu66
        zxYp+IGx3t7T0xNsNYnNO7tgFQ==
X-Google-Smtp-Source: AKy350ag43OiG3r7Vy717gSy+pX9ZevstneHo3UQq2lOby5UUvTIdpZTPDh8OAsdarK8D5U7e+8sBA==
X-Received: by 2002:a17:902:d512:b0:1a0:67fb:445c with SMTP id b18-20020a170902d51200b001a067fb445cmr8985431plg.28.1680231639373;
        Thu, 30 Mar 2023 20:00:39 -0700 (PDT)
Received: from [10.3.157.34] ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001a1ea1d6d6esm372585plb.290.2023.03.30.20.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 20:00:38 -0700 (PDT)
Message-ID: <6128380c-b148-cb7e-44d5-0bd7d05a2942@bytedance.com>
Date:   Fri, 31 Mar 2023 11:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH] blk-throttle: Fix io statistics for cgroup
 v1
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328142309.73413-1-hanjinke.666@bytedance.com>
 <ZCSJaBO8i5jQFC10@slm.duckdns.org>
 <1a858cce-4d87-5e0a-9274-52cffde7dea6@bytedance.com>
 <ZCY7EoAUqfB0ac8S@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZCY7EoAUqfB0ac8S@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/3/31 上午9:44, Tejun Heo 写道:
> Hello,
> 
> On Thu, Mar 30, 2023 at 11:44:04AM +0800, hanjinke wrote:
>> 在 2023/3/30 上午2:54, Tejun Heo 写道:
>>> On Tue, Mar 28, 2023 at 10:23:09PM +0800, Jinke Han wrote:
>>>> From: Jinke Han <hanjinke.666@bytedance.com>
>>>>
>>>> Now the io statistics of cgroup v1 are no longer accurate. Although
>>>> in the long run it's best that rstat is a good implementation of
>>>> cgroup v1 io statistics. But before that, we'd better fix this issue.
>>>
>>> Can you please expand on how the stats are wrong on v1 and how the patch
>>> fixes it?
>>>
>>> Thanks.
>>>
>> Now blkio.throttle.io_serviced and blkio.throttle.io_serviced become the
> 
> "now" might be a bit too vague. Can you point to the commit which made the
> change?
> 
>> only stable io stats interface of cgroup v1, and these statistics are done
>> in the blk-throttle code. But the current code only counts the bios that are
> 
> Ah, okay, so the stats are now updated by blk-throtl itself but
> 
>> actually throttled. When the user does not add the throttle limit, the io
>> stats for cgroup v1 has nothing. I fix it according to the statistical
>> method of v2, and made it count all ios accurately.
> 
> updated only when limits are configured which can be confusing. Makes sense
> to me. Can you please update the patch description accordingly?
> 
> Also, the following change:
> 
> @@ -2033,6 +2033,9 @@ void blk_cgroup_bio_start(struct bio *bio)
>          struct blkg_iostat_set *bis;
>          unsigned long flags;
> 
> +       if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> +               return;
> +
>          /* Root-level stats are sourced from system-wide IO stats */
>          if (!cgroup_parent(blkcg->css.cgroup))
>                  return;
> 
> seems incomplete as there's an additional
> cgroup_subsys_on_dfl(io_cgrp_subsys) test in the function. We probably wanna
> remove that?
> 
> Thanks.
> 

okay, according to your suggestion, I will send a v2.

Thanks
