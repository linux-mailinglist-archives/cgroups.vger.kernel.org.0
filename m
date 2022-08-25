Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1751F5A11D9
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbiHYNUt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 09:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiHYNUs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 09:20:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9489C1EC
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 06:20:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w20so10325727edd.10
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tGI/HgI5RJ0IOQ7oCC9l+UoRS3M/KBpS5rSBAd3MZgo=;
        b=whhwMf11JScRmGvZpTzi4pm8aQUE+LI1b+HFpqXieLoJb6OwFEWMMa+Y/SI3hiRfSa
         JVJvBQuNwEbjYGDBjUlhLzIqA8xnjXhvYDwpro7ItADA2pIOZ4lUne38Gc06R0mw4ydw
         4UAEy9/ZJ1W3J0CXMP6jJo9Ou6s22HAdt12AOj0xjT5d04mLaOjV30rQy9Mzd1ffVcmr
         4U6pSbwSpLZQy12eWKyJ/eyJUQn67mpFP0t6UmF6CMmAk9GR1k2VTGeSIfOAfAF0BJ6w
         MaWFv/K4v+A18UkkelXRxiWWvHCgEqeGL05vBTUHARhmihHnqcnkXCImasUJj5pFMN0c
         oocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tGI/HgI5RJ0IOQ7oCC9l+UoRS3M/KBpS5rSBAd3MZgo=;
        b=BEY9qOUAvzLcXUYcc8+lJF5p+/v0gySD9ZFfyKKoUSziHpBVhH6W2R8APLbtluQn7Y
         Gei8o5tD81kNEWAFuF1ITCBNzmdndn/E5euTDwdBtsKwdwoJfeaGMeFlsEhchaxcpd0b
         RA73Me3gPEGTeS01/HPVKgIEgii8CEbRjzzTDDvR14jqagnXBFqjsYTnmvNHBA2K+ShE
         vUFaStW/M8cuzpMGaNTfdl3G6FRvXxWVtKrCNXbB0U2mktDUVCazwUFpzB4X2PQuy+4j
         DuvqyoLru9mxLPWmBrI5HThdO8+rYJHVcluNTXQkG5zrM0hpE72EvoWEJyOsfWHO4/RC
         lGew==
X-Gm-Message-State: ACgBeo1XhJ6SOeLxN7dmQDp8w/qrRqFFpkh5Qfs8DNxpHlqzr1qbN3Bw
        fMcyK4L2E+7jay2xtSzpEMkxEbhx2rljdS3qdWiJXw==
X-Google-Smtp-Source: AA6agR6BOF6YHOTMnMPROJdUE9tUsTOtPD6FHwfwYHiTakQgV+VT68NMf0ZjE2YrASDCSQ8PdivlLw==
X-Received: by 2002:aa7:cb06:0:b0:446:7668:2969 with SMTP id s6-20020aa7cb06000000b0044676682969mr3214524edt.206.1661433645579;
        Thu, 25 Aug 2022 06:20:45 -0700 (PDT)
Received: from localhost (ip-109-192-149-028.um38.pools.vodafone-ip.de. [109.192.149.28])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7d0d0000000b004477c582ffdsm2874284edo.80.2022.08.25.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 06:20:44 -0700 (PDT)
Date:   Thu, 25 Aug 2022 09:20:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/10] sched/psi: per-cgroup PSI accounting
 disable/re-enable interface
Message-ID: <Ywd3K1+5blotUEtU@cmpxchg.org>
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
 <20220824081829.33748-11-zhouchengming@bytedance.com>
 <YwX2jC2UQ/zeY2E8@cmpxchg.org>
 <324b1d0f-42e5-8947-68cb-a3d20135f2c6@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <324b1d0f-42e5-8947-68cb-a3d20135f2c6@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 25, 2022 at 08:28:39PM +0800, Chengming Zhou wrote:
> On 2022/8/24 17:59, Johannes Weiner wrote:
> > Hi Chengming,
> > 
> > Thanks for incorporating all the feedback. I have a few nitpicks
> > below, but with those considered, please add:
> > 
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > On Wed, Aug 24, 2022 at 04:18:29PM +0800, Chengming Zhou wrote:
> >> @@ -5171,12 +5220,19 @@ static struct cftype cgroup_base_files[] = {
> >>  	{
> >>  		.name = "irq.pressure",
> >>  		.flags = CFTYPE_PRESSURE,
> >> +		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
> >>  		.seq_show = cgroup_irq_pressure_show,
> >>  		.write = cgroup_irq_pressure_write,
> >>  		.poll = cgroup_pressure_poll,
> >>  		.release = cgroup_pressure_release,
> >>  	},
> >>  #endif
> >> +	{
> >> +		.name = "cgroup.pressure",
> >> +		.flags = CFTYPE_PRESSURE,
> >> +		.seq_show = cgroup_psi_show,
> >> +		.write = cgroup_psi_write,
> > 
> > To match the naming convention, these should be called
> > cgroup_pressure_show() and cgroup_pressure_write().
> 
> I just find cgroup_pressure_write() already exists, so I change the names
> to cgroup_pressure_enable_show() and cgroup_pressure_enable_write(),
> since this file name is simplified from "cgroup.pressure.enable".

That makes two outliers instead of one. It's probably better to steal
cgroup_pressure_write for cgroup.pressure, and rename the currently
misnamed helper. How about do_pressure_write()? pressure_write()?
