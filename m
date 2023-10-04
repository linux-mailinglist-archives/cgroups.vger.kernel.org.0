Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D155B7B8BE1
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbjJDSy5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244710AbjJDSyk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 14:54:40 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497710B
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 11:54:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bf58009a8dso94740a34.1
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445652; x=1697050452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmAXU9qtB1zbz18w4Nloh90w0549irCsN8QhQ+w85ys=;
        b=icvdSKu+HyjypXTncLhJS0WvhjL26lkt1nLh46DnaEN0T0PNUCMNo7oi8wvfbwyJhl
         BxUprWAkJ1sFpp8k7GUBRi5ipSF7q/Fp1Dk/rYALQ/nM6Aqp/SbBAxJGxRMpvXFi9Jc+
         PZR3KSE+y8KQbTWeeUwWsiPOb4lMhp8eEkj29Z8uvfUCKQO1zUumCBkPYcwnWHl94KuM
         bf5f7p/dheaG+zuJ6QyEQj3n6isBFXCj+RYtvuvdbEW268ikI1ROnp9ElhPDZD1e6Bmb
         9OxzGcGTF/PDpPyJBvogAFLckqR4mQ26+IuTpFk78RRmdQGdw1jrhBTSkC1tAan9Qjnm
         yraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445652; x=1697050452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmAXU9qtB1zbz18w4Nloh90w0549irCsN8QhQ+w85ys=;
        b=Ul+zJaq6EG+l8aLddoPBfjhMkaKPZaA9Vd88X+Zx8TYn59wlnijNfth0dHP+TAZSHa
         9sqoWTcr9c3iEix8btLBgqv2HfFbBQ+R6xyUrqH318ySs2z8eMzovpl+qILKN2sLH4zI
         os5rqmLGrxK+JMuuFN7PDG9tXFhL+hz2LnRz1ifWGCdG5zdMFtXDiLwFoIHao1MpuzJc
         05ISktLCgmsKHyc7moyoRarXV9iHt8qubYp/7/xFSR8rOi5eQ6VuCrbbeWuDNhxi0FXA
         keKeOgY1SZPtQWngx4z0QJ2YhLizwR+sv75AWpWlkQRjpDeqzSfTPkaEPdrEkGWeKup2
         sc8Q==
X-Gm-Message-State: AOJu0YwYsEwjmxpF3JLWN5/GDXb+4P6vTlScylNXAraUNGLeNtU2KMbd
        tXklShtK3FnmqKmObndEFak=
X-Google-Smtp-Source: AGHT+IHfbLoUnEDs9U8e7uSVP7BufT9EcOoG3LFWjgU4dwK47j3+FYQaqLIAScSI2HzhWMBwQ5m7xw==
X-Received: by 2002:a05:6358:788:b0:142:d097:3725 with SMTP id n8-20020a056358078800b00142d0973725mr3313283rwj.9.1696445652255;
        Wed, 04 Oct 2023 11:54:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id b13-20020a63d80d000000b00565dd935938sm3723307pgh.85.2023.10.04.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:54:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Oct 2023 08:54:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
Message-ID: <ZR200rty1bYXkVqv@slm.duckdns.org>
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 03, 2023 at 11:01:46AM -0700, T.J. Mercier wrote:
> On Tue, Oct 3, 2023 at 10:40 AM T.J. Mercier <tjmercier@google.com> wrote:
> >
> > Hi all,
> >
> > Samsung reported an Android bug where over 1000 cgroups were left
> > empty without being removed. These cgroups should have been removed
> > after no processes were observed to be remaining in the cgroup by this
> > code [1], which loops until cgroup.procs is empty and then attempts to
> > rmdir the cgroup. That works most of the time, but occasionally the
> > rmdir fails with EBUSY *after cgroup.procs is empty*, which seems
> > wrong. No controllers are enabled in this cgroup v2 hierarchy; it's
> > currently used only for freezer. I spoke with Suren about this, who
> > recalled a similar problem and fix [2], but all the kernels I've
> > tested contain this fix. I have been able to reproduce this on 5.10,
> > 5.15, 6.1, and 6.3 on various hardware. I've written a reproducer
> > (below) which typically hits the issue in under a minute.
> >
> > The trace events look like this when the problem occurs. I'm guessing
> > the rmdir is attempted in that window between signal_deliver and
> > cgroup_notify_populated = 0.

So, the recommendation is to always trigger cleanup on the !populated
notification. That said, I don't immediately see why your reproducer doesn't
work. I'll dig into it later.

Thanks.

-- 
tejun
