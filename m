Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46AD756E63
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGQUhM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 16:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGQUhM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 16:37:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1796103;
        Mon, 17 Jul 2023 13:37:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34884a8f285so10380015ab.0;
        Mon, 17 Jul 2023 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689626230; x=1692218230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kAwJHiR+H4GDqr7e6nXyr8bmo5EmU5aiLGkOZNmvaM=;
        b=kmeBqa5MdbvFwdthLNdn6x5K0aMOzpJkcGZV6u06eY00afZa0fY9RvCh6intNP8pXp
         ova0U7D4MjTIHFXVKb77udj94AQogskNUHixxA7OnLXGJPqGQg6Ye8E8Nr80P7xmVjtH
         AT+CNgtY69k3C9UANOeU+fLg0WgCyuVlNL42ktb03Tr4Ttm67yY0eM3nIU9UTMc/OHvx
         59KCftrig2iDJHxr3GXZJA7GmYbli/hP5Gfi8PyDKfKvTV/Uc6F+p1auVV2NYVy0z5kj
         3RopdAE1ZYsq0E5J5tInZWS6tPHLNKqw1jaKxPBBsjVes2aS1YV/KBTdgWJzhzxViEOO
         segw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626230; x=1692218230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kAwJHiR+H4GDqr7e6nXyr8bmo5EmU5aiLGkOZNmvaM=;
        b=QPpwyUtlxd+3/M46cPFcTUr5s41naeuwDX2qra/T0d+MjQf6WhX5an5Vf/2+A5DzwC
         o5MyVi7cnDoLMAAyb7ernvdZeR/+F4KfM6R85R//UZwI1Y6m4dVH2KEKawEVW9Mc/Ii9
         MMifR3CrB5WTGEaXsunekiajs7ShtJhQWj0tjPdL5aupEFPpa/xQFP4ySyzY0EnVpSC7
         BBOxHplYVonVTDajdp1DSuP4v3pMYnSjqlq9h2BtWg6xYdvKcfJtWYNyX5P6gGlQcifr
         EygUxwQ2/sJ1osOv7oCY4JDdjjlKZObwOKAlV1rYpLl6xmr5v2hmdKyfnzHnVCCB0kzB
         UPqg==
X-Gm-Message-State: ABy/qLbh/sTRckKyzlbVPFyKIfAurNbn4YR6h5LRSTfih4QmA02ethDS
        arXAmG+ISWygXwfN4nAWl4g=
X-Google-Smtp-Source: APBJJlEKXWlw+c5R6v5A6AbZDdFfolPCLTWSYnbtuLHMsBAPUBd5oy2WlAN/RWB7XzfShnMndpZc1w==
X-Received: by 2002:a92:c943:0:b0:348:7c4e:2959 with SMTP id i3-20020a92c943000000b003487c4e2959mr644960ilq.23.1689626229961;
        Mon, 17 Jul 2023 13:37:09 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id a12-20020a92d34c000000b003426356a35asm199726ilh.0.2023.07.17.13.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 13:37:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 10:37:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, vipinsh@google.com,
        kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: Re: [PATCH] cgroup/misc: Fix an overflow
Message-ID: <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
References: <20230717184719.85523-1-haitao.huang@linux.intel.com>
 <CU4OCLEHU1S5.359W394902648@seitikki>
 <ZLWPN_xyGFrqqJkV@slm.duckdns.org>
 <op.178pr1qewjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <op.178te0tbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.178te0tbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Jul 17, 2023 at 03:19:38PM -0500, Haitao Huang wrote:
> Actually, we are using atomic_long_t for 'current' which is the same width
> as long defined by arch/compiler. So new_usage should be long to be
> consistent?

We can use atomic64_t, right? It's slower on 32bit machines but I think it'd
be better to guarantee resource counter range than micro-optimizing charge
operations. None of the current users are hot enough for this to matter and
if somebody becomes that hot, the difference between atomic_t and atomic64_t
isn't gonna matter that much. We'd need to batch allocations per-cpu and so
on.

> ditto for event counter. Only max is plain unsigned long but I think it is
> also OK as it only compared with 'current' without any arithmetic ops
> involved.
> Did I miss something here?

I'm saying that it'd be better to make everything explicitly 64bit.

Thanks.

-- 
tejun
