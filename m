Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781E746216D
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 21:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353205AbhK2UJG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 15:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbhK2UHF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 15:07:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F0C08EB32;
        Mon, 29 Nov 2021 08:39:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m24so12627430pls.10;
        Mon, 29 Nov 2021 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uN2SDh1OpNAmwOV7/X9bwxMmpaiYU2WulSlLqtLkQkY=;
        b=KK4Dw2fMZbfFmVV6q17Pao6/+8xYHausH2l199e4NYZgTZVnoLqC4hb9YmsqEviUME
         lsMzIDH3kTgDBKYo0FSwi7y/khD9Oi6Snyc8BOjJLVmdDVBFYZKiT9tX0oof2fVn78Td
         CEtOJpLA0+Ucaq8lW2DUoJRed8CZzP8kngbXXiaU9LewFmRAAel019T2AgVXZjfvQ0Yr
         yZQRRElxoAy8PXgjTNNFPazB6/W9imiFRJMYVJiR1pVdJbU+G6s9M5QMy/3S439s8uLd
         umtxOw5ja4oKXXyaq+6X92gzcngC9Jo5tGDhmNPwgDE5gOZuv4A0claZyUAZ7JKHsaby
         6tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=uN2SDh1OpNAmwOV7/X9bwxMmpaiYU2WulSlLqtLkQkY=;
        b=wBid8Tasf4JVAsOgPIQPATla/RmDCOwzrNYVM4vq6wtmI7r0I+Tf9i0vILjHDRtMRR
         OPHg8FmjtzijjED81IOd/4qY2F8KrTS8qxwVVxtLPYzFQ6TM61/xpnXVp0l94i99lOED
         zVk9jlrE16HhRbdlXDd1eewIoy13ucmT9L99OCOIDubdcHcFiXz3dCN/BbZ5EmdfyV0w
         bMV5b5G+wbpnNN6IXziNBAeFrlZFPIrHrRR/fqaC7kyRx7FUnROuy3oL+j0iXVc6zUlA
         CGf1EeeR4ae0RoAczz0dAJrVhZsX2aEkpylKNqubtj4Q5IkRcP2VSIa2XzTa5UH61lDZ
         HfKw==
X-Gm-Message-State: AOAM530Li9Yoyx6fmND5nCMdI0iDqHcPwc3boqPfX7WI9Z1Aaq9r0I0a
        +IHFlSWW8X/PBIva01si+Qo=
X-Google-Smtp-Source: ABdhPJwsce6JNL3BXrC9YmBIW6cNk4pwJ4A/vRLwu74ByiMvbFIWNg5ub+RKcUsVlOHiwMuVpdONpg==
X-Received: by 2002:a17:903:11c4:b0:143:d220:9161 with SMTP id q4-20020a17090311c400b00143d2209161mr62903359plh.2.1638203977223;
        Mon, 29 Nov 2021 08:39:37 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ne7sm19524292pjb.36.2021.11.29.08.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:39:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 29 Nov 2021 06:39:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        minipli@grsecurity.net, Valentin.Schneider@arm.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, kevin.tanguy@corp.ovh.com, mgorman@suse.de,
        mingo@redhat.com, odin@uged.al, peterz@infradead.org,
        rostedt@goodmis.org, spender@grsecurity.net,
        vincent.guittot@linaro.org
Subject: Re: [RFC PATCH] sched/fair: Filter by css_is_dying() in the last
 tg_unthrottle_up()
Message-ID: <YaUCR4a0kes5XvF4@slm.duckdns.org>
References: <20211126130619.30730-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126130619.30730-1-mkoutny@suse.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Nov 26, 2021 at 02:06:19PM +0100, Michal Koutný wrote:
> As explained in the message, this relies on the RCU GP between css_is_dying()
> returning false and the potential .css_offline() call. 
> This is stated in the css_is_dying() documentation:
> 
> > the actual offline operations are RCU delayed and this test returns %true
> > also when @css is scheduled to be offlined.
> 
> On the other hand the documentation of the underlying
> percpu_ref_kill_and_confirm() says (to discourage relying on GP):
> 
> > There are no implied RCU grace periods between kill and release.
> 
> This seems to discord with each other at first thought. (That's why I marked
> this RFC.)
> 
> However, if one takes into account that percpu_refs as used by css are never
> switched to atomic besides the actual killing (and they start in per-cpu mode),
> the GP (inserted in __percpu_ref_switch_to_atomic()) is warranted.

IIRC, one reason why I didn't want to make the implied RCU "official" was
that there were different RCU types and cgroup was using the less common
preempt variant. Now that the RCU types are unified, it may be okay to
guarantee that e.g. percpu ref offlining has a guaranteed GP and then
propagate that guarantee to the users. It may still be a bit brittle tho in
that we may force the percpu ref to atomic mode for e.g. reference leak
debugging. It'd be great if we can trigger a warning if we end up missing a
GP for whatever reason.

Thanks.

-- 
tejun
