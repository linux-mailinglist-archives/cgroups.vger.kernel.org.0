Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B264DB639
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbiCPQcj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiCPQci (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 12:32:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1A26D4CB;
        Wed, 16 Mar 2022 09:31:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t22so2270028plo.0;
        Wed, 16 Mar 2022 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0li51S2j9zx6touwa3lalaBuNLB+ApBmTIWJmdTR4CI=;
        b=CMYlilISkpmT9u93kuzE80ilYUmxO8tZDHP6kRvGqaeCD3IgCfRgtxtt4ui3m8C8N3
         9QtIz4konuRNXrXD0iyToy2A4HfrIhnctNOUmpZYxsjwupqLpl7K0F3OdK7bv76ZfG3S
         d7I15BTZRPEIinQ3m0FkfvWkUcwSGR1Kc3/jiio7PtNWUUHFlqir/2VM7IQD1imzBbID
         DSr03q7fwGP/+dxbERzS+cdO5t1v3YENg18f8jVBEZpwv4qnrRc58kP/y7mbEgt4vj+L
         LHrdRCBMigiHY3BFJ70y/qpNf8P39NsI9ElYBYDeI1G4SH0cV9bcMzQpwjbmUyBVJ7Ta
         M/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0li51S2j9zx6touwa3lalaBuNLB+ApBmTIWJmdTR4CI=;
        b=YqexcZ0zvvhvDCFGzhaPwSKErTOwEux0rwnTYz7zsVCdFTa7Cwujj21214cX/F/K7a
         hizvKEX9bqO+SHOITlCLSZ6+mkO4mCG8EpJ9bIMUjxCVANDEqA0Z9OWx8c6WjhJPC11C
         ip+KXQhJ0YK5d6T2vp2YdxdkzPdTkTsp9XVdrfbVIglXr7TAkWrLsujNH7iq8KWOI8l/
         nNrSiWmz4mdGuUNLGVxjsnTC8FP5jM77M3TdYzfzRwkgbc0I3yG3kor0jXrt3WO91A8l
         SraiA+gQLVjhmCLAqo6BOduD3bhZ77OG12iGlR/mfNixXmFf/ByVTUPRRcq2R/e2Pl7t
         xfFg==
X-Gm-Message-State: AOAM531En/eHjasR3Idjaad1YWSFeVayT02XpHPmMsRJrnfzg4T4V+gk
        Av1u+wzCCm0asi9pYag8BGo=
X-Google-Smtp-Source: ABdhPJzEVxA0lPXRLR3lK6epsQ90ZVHK5W+GGO82avyXJSn6CEsL4VYY2Tdi1UmAoEVuQTAdoHvncw==
X-Received: by 2002:a17:902:bcca:b0:153:88c7:a02 with SMTP id o10-20020a170902bcca00b0015388c70a02mr338759pls.112.1647448283647;
        Wed, 16 Mar 2022 09:31:23 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090a841700b001c678ac3b4bsm81977pjn.14.2022.03.16.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 09:31:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Mar 2022 06:31:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
Message-ID: <YjIQ2c8CoMDDaUeT@slm.duckdns.org>
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
 <CAPhsuW5qHSZNSEh8CQK3wYqtJ4XB+EwFEJWKA9SkA+wGFbvNCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5qHSZNSEh8CQK3wYqtJ4XB+EwFEJWKA9SkA+wGFbvNCg@mail.gmail.com>
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

On Tue, Mar 15, 2022 at 11:04:56PM -0700, Song Liu wrote:
> Lookups invoke a rstat flush, so we still walk every node of a subtree for
> each lookup, no? So the actual cost should be similar than walking the
> subtree with some BPF program? Did I miss something?

rstat only walks cgroups / cpus which have been active since the flush.

Thanks.

-- 
tejun
