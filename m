Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5979D5A30CE
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbiHZVII (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZVIH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 17:08:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03011DDB55;
        Fri, 26 Aug 2022 14:08:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pm13so2688756pjb.5;
        Fri, 26 Aug 2022 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=EL3E1bRaXeyNPnn48uCzkwQGEAza0WH8uE9MHfXwpc0=;
        b=i3YwUXBW3Qx0me4zpUqZraIl74Huj1RpfYz7z+IuUhZo8SwtbtnxO3ywnqrwA6VEEO
         feIkxua5CDvMVasxdksGBqUzDRYIiAaYLbtWBa6D75vAF7h0gmZWeySezUDeC55MqIgB
         +V0QRRz0uVhmBgWK6PLMhtEq92jODckRFg69kOtFjBRz+s9YXljL56Q0RR9txGsoH8dN
         Vm3ykAM4wFf+18yQuQC/iMGtcBtggjF7J3u/1UzVCGV54m58fi6wBclz6j2EQvFRJXJy
         Lb9Mf154iT9BkCEsBWDJVC1DITZuDu6tNCp8A/yYJ16XO/Ht8U4lG2gfcCKY2ZrlluQN
         mUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=EL3E1bRaXeyNPnn48uCzkwQGEAza0WH8uE9MHfXwpc0=;
        b=atvdeda/eWyGtbX+9ITQ2vr1Ej33niCQEY9AChwpL31fzRYsungZ3wO7PQueobFS+O
         nrxMjHZBBK06LQPNq9+yeZkanPFlxF8Z00PWADHCTibH0oxRUycgV8jRRXjkywmMBEPX
         X0WhxpJPTRV1HGixKo8wFmd+3I8QJybaBUiySnz1Nrmp2hGbHYs398YsUNnbGDkJfWmk
         ZD1I7s7Fl6y9rFYFWLKLGqJ6eOSJeY1qt6BrYJ9FA512WDiWKEHX3bNNB+35K8Vgz5xu
         nA18BY5VD8t0NjTyNf2HfE0cCoy7QTCW1H/rLyRxtmSPYzZs+wEWpCwgGEgsxatL8rpV
         iGrQ==
X-Gm-Message-State: ACgBeo2EQ4qF5eA9K7E8mftWZkdfC3anxS17ll/6gDQzhwANXI7sUydg
        aUubKvfHKhqfuJ7P/d3nrH8=
X-Google-Smtp-Source: AA6agR4bTy7FuIuWRhLxNgLQmG/xUOoAmwZ9Ea+deM5ZF34lH23v6X64L3j11xCFX9Dc7/Sp3twVtw==
X-Received: by 2002:a17:90b:1e08:b0:1f5:1f0d:3736 with SMTP id pg8-20020a17090b1e0800b001f51f0d3736mr6349175pjb.58.1661548086391;
        Fri, 26 Aug 2022 14:08:06 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z62-20020a623341000000b0053670204aeasm2173398pfz.161.2022.08.26.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 14:08:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 26 Aug 2022 11:08:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        bpf@vger.kernel.org, Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 0/4] Honor cgroup namespace when resolving cgroup id
Message-ID: <Ywk2NMwurnBYhU+D@slm.duckdns.org>
References: <20220826165238.30915-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826165238.30915-1-mkoutny@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Aug 26, 2022 at 06:52:34PM +0200, Michal Koutný wrote:
> Cgroup id is becoming a new way for userspace how to refer to cgroups it
> wants to act upon. As opposed to cgroupfs (paths, opened FDs), the
> current approach does not reflect limited view by (non-init) cgroup
> namespaces.

Looking at the code, I'm not quite sure we're actually plugging all holes in
terms of lookup. I think cgroup_get_from_path() would allow walking up past
the ns boundary. We aren't using kernfs ns support and I don't see anything
preventing ..'ing past the boundary.

> This patches don't aim to limit what a user can do (consider an uid=0 in
> mere cgroup namespace) but to provide consistent view within a
> namespace.

Considering userns and the fact that we try to isolate two separate sub
hierarchies delegated to the same UID, I think we'd have to tighten down on
the behaviors so that visiblity scope matches the permission scope.

Thanks.

-- 
tejun
