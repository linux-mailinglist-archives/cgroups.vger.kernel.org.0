Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50837742BC
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjHHRtO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Aug 2023 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjHHRsw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Aug 2023 13:48:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B383C25ED1;
        Tue,  8 Aug 2023 09:21:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6874d1c8610so4229937b3a.0;
        Tue, 08 Aug 2023 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511672; x=1692116472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQjuyyNTy33tUChendA12c1wzE5rL9uSYQp+xAh/JHk=;
        b=oWVgu9FnRlZjuS3BL5oIvNY6f7zFl1L1NND+TyyByiDK7tpbp4Qa55TbCQ5IO/iv85
         ILSMg6DUOmdq3uhQ9fkfbLvPbh1L9ShW7sv89RVJN+9k8M179GvyEFtr38vI1lr+99lp
         YnUdXM5NmleR0BBhqaD3VGDv+T+8zho3LyfvZOKkJRFa0gibQl2gxZWbLZ69K3AKNlZ9
         82FhqBz9KXn53zaxFT7A2kvaYb9n4h2k57ZPmfa3aye5CHMPpGiIY/8DzwEq3KUKX9+8
         HWB0y8l8WWaw7z0NOMEukwZPp2xV/9eQ/VXuGU2s3zM1vpDQVe0xcTElMcWOd6WOGJlt
         fA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511672; x=1692116472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQjuyyNTy33tUChendA12c1wzE5rL9uSYQp+xAh/JHk=;
        b=TyWbjgMCsj4qTLNmpEhGVU+kwcGLA+9gIEYePV04YwsJCrPo1HmquEFbRYZrOwHi+A
         rjVPmQa61savDTdcNFKWVZPgj/3ceg0J4rurOiorUgQYiRR3oMjZ3n+odFihfS3iojFl
         +B3f5+9zINZAFb57xecx6JI60csg9BPMpewwPeW9A1L53W0Il2M1i5GuJqVuk4XMB1vF
         HyjexBBuUxbg2SOafVpi5KBYRogh6e11nUsAUlddkXiPS3eqNCzoc7m4irywhTPrVi/J
         Ash11yUYecxo5AnTxE+Zyj6/RZldy6kLZh4aVtNK/4eTvEJw4ta6VJKr0H1u3LErt5ki
         qLOA==
X-Gm-Message-State: AOJu0Yz3qR4bS2w6sL9ZGfAAb34xq43hrO7AQJYDqvBxOYwxqWq5RUrm
        F9wnYahjVW+6lASkii6jAyPZO05AoPnS3VG4idXHMVie1sS8Cg==
X-Google-Smtp-Source: AGHT+IGy4BAla9+7n6rMgv5yJV+FaEmRuLNz3pCHRXSde5Fw0n8+lLXxJ1cce3w4g+PuJhKuaFIiaJlvsSpVq52hH3w=
X-Received: by 2002:a05:6870:5494:b0:1ba:2c95:a168 with SMTP id
 f20-20020a056870549400b001ba2c95a168mr13750691oan.35.1691496643494; Tue, 08
 Aug 2023 05:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230808022229.1560559-1-xiongwei.song@windriver.com> <ZNGsz3FC6q/jJ0+Z@casper.infradead.org>
In-Reply-To: <ZNGsz3FC6q/jJ0+Z@casper.infradead.org>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 8 Aug 2023 20:10:19 +0800
Message-ID: <CAEVVKH8yxY7bbSS4i10rFBT6uq1x99n+R2=SEs73uvWr0zMXyw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: add tips for kmem.slabinfo
To:     Matthew Wilcox <willy@infradead.org>
Cc:     xiongwei.song@windriver.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 8, 2023 at 10:47=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Aug 08, 2023 at 10:22:29AM +0800, xiongwei.song@windriver.com wro=
te:
> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >
> > No any output from kmem.slabinfo, which is not friendly. Adding
> > tips for it.
>
> What happens to tools which look in this file?

I thought the mem_cgroup_slab_show() function should be removed or
provide some useful info.

Thanks.
>
