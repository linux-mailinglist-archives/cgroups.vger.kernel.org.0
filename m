Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83B53BAC3
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiFBO2W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiFBO2T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 10:28:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA11140845
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 07:28:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso9536214pjl.3
        for <cgroups@vger.kernel.org>; Thu, 02 Jun 2022 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=L4Gxk4Bv5TfkgMZFmRZVdKI/nfnxSbVJuJD+KEhCTwA=;
        b=vznR9E/huPyrIZXpXnkqdLBfuApJkQscKlKcZknXDqfZ/UzpBujU19WWiJ4F6oTRe2
         lR7uP5EHAzxXwKjHa6B5RqiR9qnOaBkPs/hQSA9fnvdrxoQ3mFlfPq0VrvKG3gS6OE8R
         plY2qTLcDyWkxvE1BNieB15nFdOsnxMIE+Z3bRp/rMWZr/XzOq6qPJcP4JcL5r7v8+Rb
         AuEZVAjpLmZiBKWgqlash0NfkGGjUBMR+u0O48hccdnAFA9NmfkAD3b9WxtR17/cgOAz
         DCZGvSeh7xnKG8Wnji3N5tPQM53K3hXQH89J3bXgB0U78Q5roB6xZZQCZ+Ql/XFJLHXu
         pSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=L4Gxk4Bv5TfkgMZFmRZVdKI/nfnxSbVJuJD+KEhCTwA=;
        b=AbzoAcWGUlLlB6PGuMZwG52dikl0JeMKQ+xhi9ZJn9vy1ArETINiuQqvS2drlumRL0
         zWLVRKRuOE3uA5/dmpweFea/AdfrB1uzfvVZzE4IYFZA1XljYXunGrEUMO99MnklgRAp
         mTshDrmuEGLgwv6eUpnBK5dvZrbd797h1PBqimrOSxNsTFYYpiOS+PsDIrPx4Eko6shV
         v/CP9htCp/Ns5S5xrZysytz06Qg2C1DMRMP7mzZZW7826s6BDmH8NstpBBuwWHizEXU7
         vtK5MtsLHsM/XFjov1QJzJ1wJzt8XT92NXy2iVyAynofCaNT2SWBD5jRhmUKrLfCAF+D
         WrKQ==
X-Gm-Message-State: AOAM531odBrw7MXjxhCwcTUJOVOk4UrWGeTkOueSEMEALlvRdTWU+uyo
        iJzmTMiqx8wE+BaBipIKlauDtL6IZxuCKw==
X-Google-Smtp-Source: ABdhPJznhWKPETXcZJrKMM+bn5m7VYTIN0w3D9vJ7qTBPI6tQ12pVtLVSqQrS4E7he1I2F8wZslmWQ==
X-Received: by 2002:a17:902:8f81:b0:161:f4a7:f2fc with SMTP id z1-20020a1709028f8100b00161f4a7f2fcmr5196569plo.117.1654180097855;
        Thu, 02 Jun 2022 07:28:17 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b0015ed003552fsm3564512plh.293.2022.06.02.07.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 07:28:17 -0700 (PDT)
Message-ID: <1e4fe5c8-4bac-087b-ae32-6fa2fa5b44f6@linaro.org>
Date:   Thu, 2 Jun 2022 07:28:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
References: <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
 <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
 <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
 <c3bd8e63-7204-f86d-8efa-254db71185fc@linaro.org>
 <Ypf/MpwzByOrSp6A@slm.duckdns.org>
 <416dc60a-f0e5-7d05-1613-3cd0ca415768@linaro.org>
 <YpgEY/lJbLidLOhc@slm.duckdns.org>
 <0fd1c3fd-fa86-dbed-f3f0-74c91b1efa11@linaro.org>
 <20220602114705.GB21320@blackbody.suse.cz>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
In-Reply-To: <20220602114705.GB21320@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/2/22 04:47, Michal Koutný wrote:
> On Wed, Jun 01, 2022 at 05:40:51PM -0700, Tadeusz Struk<tadeusz.struk@linaro.org>  wrote:
>> css_killed_ref_fn() will be called regardless of the value of refcnt (via percpu_ref_kill_and_confirm())
>> and it will only enqueue the css_killed_work_fn() to be called later.
>> Then css_put()->css_release() will be called before the css_killed_work_fn() will even
>> get a chance to run, and it will also*only*  enqueue css_release_work_fn() to be called later.
>> The problem happens on the second enqueue. So there need to be something in place that
>> will make sure that css_killed_work_fn() is done before css_release() can enqueue
>> the second job.
> IIUC, here you describe the same scenario I broke down at [1].

Right, except the last css_put(), which I think is called from cgroup_kn_unlock()
See below.

>> Does it sound right?
> I added a parameter A there (that is sum of base and percpu references
> before kill_css()).
> I thought it fails because A == 1 (i.e. killing the base reference),
> however, that seems an unlikely situation (because cgroup code uses a
> "fuse" reference to pin css for offline_css()).
> 
> So the remaining option (at least I find it more likely now) is that
> A == 0 (A < 0 would trigger the warning in
> percpu_ref_switch_to_atomic_rcu()), aka the ref imbalance. I hope we can
> get to the bottom of this with detailed enough tracing of gets/puts.
> 
> Splitting the work struct is condradictive to the existing approach with
> the "fuse" reference.
> 
> (BTW you also wrote On Wed, Jun 01, 2022 at 05:00:44PM -0700, Tadeusz Struk<tadeusz.struk@linaro.org>  wrote:
>> The fact the css_release() is called (via cgroup_kn_unlock()) just after
>> kill_css() causes the css->destroy_work to be enqueued twice on the same WQ
>> (cgroup_destroy_wq), just with different function. This results in the
>> BUG: corrupted list in insert_work issue.
> Where do you see a critical css_release called from cgroup_kn_unlock()?
> I always observed the css_release() being called via
> percpu_ref_call_confirm_rcu() (in the original and subsequent syzbot

it goes like this:
cgroup_kn_unlock(kn)->cgroup_put(cgrp)->css_put(&cgrp->self), which
brings the refcnt to zero and triggers css_release().
I think what's missing is something that will serialize the kill
and release paths. I will try to put something together today.

-- 
Thanks,
Tadeusz
