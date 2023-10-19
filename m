Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099207D0236
	for <lists+cgroups@lfdr.de>; Thu, 19 Oct 2023 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjJSTIR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Oct 2023 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjJSTIQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Oct 2023 15:08:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8144112F;
        Thu, 19 Oct 2023 12:08:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso62328b3a.2;
        Thu, 19 Oct 2023 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697742495; x=1698347295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2xXWLhYvowWU8V3Iywrvabpuc1fUAwAUM/Ptz/LUUs=;
        b=m4GUUD6+NVismyF51jiEDvlQHjF6YoaW93ZrgzNNo92sCK9tuq7iv0wE2hfNtmsJRI
         7oY8k0L2wZ36wBXnA6QdlkStysTHNRx5nyXOMgBks6YlJc5yqhjzQBDj13thCjjs5+Ra
         N7iIOW2ioop33UnrJNQM5fspgevK4k5EdXmZGw+V4hruUiU0LHXgWMkZGg5vkCAYrt2F
         LEru+lQoHEPbiyva9UprNntSrOgLi/If3cjztKeDvC/geyRFHe/Ax7rMwDnH2DdA8y+O
         /8kvy/KJpAJ3nNxTKYBn1A5XkyEKDM8wZKkzHHZxl2d4zOR0q00FDDxvOG8w/uxl02tx
         jKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697742495; x=1698347295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2xXWLhYvowWU8V3Iywrvabpuc1fUAwAUM/Ptz/LUUs=;
        b=wREbAa6R83RgsJ0svIqB7p8hyfZmwjWaAXPQdlXsjYUp+2LWgbcdq22A/U0FgyBPDj
         QeunhfklqcnbqeGPxD/pTQ8IFLNeT95COtSxm9DyyacZ0VycWSWHCzXG+95oBCuJ8QSP
         4LOqNtlUeTaTquKwdTfq3215pidBC6xDmIsQLbyeNpMra7DgMQl23UIRxRSHDZXUSL62
         qym0joas1k6kARxEv2vlFpJK37NuV85R8J3mvZf0d5m68SBlun0wigTrVFJsyXcIXYPy
         fQ8vwTl4n1BH187npvgP14+n/a0U04UqP+uapXV6KelN1u+gWJRbBiXxoc4gWVc8tU86
         NdjA==
X-Gm-Message-State: AOJu0Yw8dKhmLGZP9e8BI2KSq3hHflRNpD3U9gja1Q5S7hDlb5YyMo+q
        SBb/VC31XlFUqL9FekkeO70=
X-Google-Smtp-Source: AGHT+IFSkm6n7uix0xQmcoUu4i6Z+poVfqXtPJ20frsWP5fg3iNWdkFkKZ67PviW9fMhXESCSd0NlQ==
X-Received: by 2002:a05:6a00:194c:b0:6b1:cc77:4d2 with SMTP id s12-20020a056a00194c00b006b1cc7704d2mr3211937pfk.15.1697742494734;
        Thu, 19 Oct 2023 12:08:14 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id u8-20020a654c08000000b0058901200bbbsm87138pgq.40.2023.10.19.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:08:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 Oct 2023 09:08:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the
 cgroup root_list RCU safe
Message-ID: <ZTF-nOb4HDvjTSca@slm.duckdns.org>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-2-laoar.shao@gmail.com>
 <ZS-m3t-_daPzEsJL@slm.duckdns.org>
 <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 19, 2023 at 02:38:52PM +0800, Yafang Shao wrote:
> > > -     BUG_ON(!res_cgroup);
> > > +     WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
> >
> > This doesn't work. lockdep_is_held() is always true if !PROVE_LOCKING.
> 
> will use mutex_is_locked() instead.

But then, someone else can hold the lock and trigger the condition
spuriously. The kernel doesn't track who's holding the lock unless lockdep
is enabled.

Thanks.

-- 
tejun
