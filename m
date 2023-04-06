Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EA16D978B
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbjDFNCq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbjDFNCo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 09:02:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FC83DC
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 06:02:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q102so37159424pjq.3
        for <cgroups@vger.kernel.org>; Thu, 06 Apr 2023 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680786142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IfVjKlL+j9HlDI7Ywy3orPIREWTrRC6HkOIMTjgyE5A=;
        b=Qq/l6ip9dMiziIBWzW4ToFmAn29Ri9O4CLmtTYSR9Rz/boVf5FqBfGnqMOcOXdl871
         OQ7dEnKcBtY3M2meImEZvKvOfNu5wgcXc0gK7l8UePg0fbk2zzDD2tLyswobRChXf9sz
         A/8E0beNTT2d+D33WGr5dnvPoI3tTfvpEQKVKB7+wLndb6fqivDB9ogculITxgCfgcka
         VQAp/K5HfnUnuB57LNJBCVU6rDivf48a099xNNbdkQD9gvaSg+HM5hld30/hI+eeqo/y
         wGBxYExdN2uDvwnfyGVIYgKegzvoh1HRUajMaxoFVUSPb/bCVCJjcd8BHWltUMtqfOF6
         H+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680786142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfVjKlL+j9HlDI7Ywy3orPIREWTrRC6HkOIMTjgyE5A=;
        b=Y00/zidwv9g2N8StDv5/bkFZL23p2ZQU7gYPeZ81HghhLbXf+sZMWlDPpuF/qL06Qs
         QksIRu/zstQW48o0zsnwe3uRCnmecVeUq4heu/oL1mxPhX+miAuj2vfqbKrsmFT1c9oh
         /oC2/upj17P9jIDG6Ila9BYzuOKd/uRrqq4EPIBhlsH14c8TQwtsxS5UdNsPpvDnVE1R
         tCvlibxH40GA4j8plG89A0SbhsqrL4ruE46sSSOl8Y9KV4+Ju0O5Ye1+AJAl6RtJ8SXC
         F9nPKDQwC4nbNVIoErlP0gF74tCTQPwXOdRk6uIw+x18YswXmYakZ0gmgelwKw0SN29O
         GqKA==
X-Gm-Message-State: AAQBX9eIVEHP5zLqKQZ/BkkwjXoFiDdmuFkBjoF9CLW0H05YUYIfq6EQ
        en/Ywt8ROA/hYOPIi/sInZhbMQ==
X-Google-Smtp-Source: AKy350ZwFTIV4Y+QNBBDhz/z2ExgzhB65rArbxoEyAk3ePPx4PYa3m3riib4Ts7ft3askmwpj08IDQ==
X-Received: by 2002:a05:6a20:7b11:b0:d7:34a1:85b9 with SMTP id s17-20020a056a207b1100b000d734a185b9mr2944043pzh.7.1680786141802;
        Thu, 06 Apr 2023 06:02:21 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id t23-20020aa79397000000b00627eac32b11sm1311597pfe.192.2023.04.06.06.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:02:21 -0700 (PDT)
Message-ID: <cc77d706-7baf-951b-13a5-3470c2b1bba9@bytedance.com>
Date:   Thu, 6 Apr 2023 21:02:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: [PATCH v2] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>
Cc:     rientjes@google.com, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
 <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
 <342c1967-8a68-275c-042e-765d5993157c@redhat.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <342c1967-8a68-275c-042e-765d5993157c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/4/5 01:24, Waiman Long wrote:
> 
> You will also need to take cpuset_rwsem to make sure that cpusets are 
> stable. BTW, the cpuset_cgroup_scan_tasks() name is kind of redundant. I 
> will suggest you just name it as cpuset_scan_tasks(). Please also add a 

mem cgroup oom use `mem_cgroup_scan_tasks`.
How about keep `cpuset_cgroup_scan_tasks` for naming consistency?

```
static void select_bad_process(struct oom_control *oc)
{
	oc->chosen_points = LONG_MIN;

	if (is_memcg_oom(oc))
		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
	else if (oc->constraint == CONSTRAINT_CPUSET)
		cpuset_cgroup_scan_tasks(oom_evaluate_task, oc);
	else {
		...
	}
}
```
