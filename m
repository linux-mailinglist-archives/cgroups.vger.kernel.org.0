Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E78F6E3BB8
	for <lists+cgroups@lfdr.de>; Sun, 16 Apr 2023 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDPTv6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Apr 2023 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPTv6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Apr 2023 15:51:58 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EEC5
        for <cgroups@vger.kernel.org>; Sun, 16 Apr 2023 12:51:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fbee98814so150634147b3.8
        for <cgroups@vger.kernel.org>; Sun, 16 Apr 2023 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681674716; x=1684266716;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XV1SaR4oDj2LmHIYbtEP9BS2GzUn6i8QGpmiK2pWes=;
        b=35GxN9QmW2hjy0Dfkmb2w05f+ZtVlxILgN7uYJpNWJLcIPK3szAO7GVlFCTIxLRIFw
         ovaBhQJgVADB9Q6ICg7hyMv/NAh8j0wq800X9YdYJ/dDjbdghw8JokHMRoEQNsIdRkdC
         WLiQXpG4Q+TttdZCcEbXfxWBxXC2GFAHRO1LtQZQgEpcMxrKREN4Avy2QCWCb6+mN3qa
         FRLCFpSJV0ak+dFRGggbPcpzGTkIvZjikma5vN7FHtcFbl8p3SNMYoZ+VAOk0dtr67BG
         CWcPeQAuI2DkTnaae9/D0Af3q8cBuCh0xrhWT3C7wipnfK4eVsi6qPFipvyeb/FiaUE3
         Z2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681674716; x=1684266716;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XV1SaR4oDj2LmHIYbtEP9BS2GzUn6i8QGpmiK2pWes=;
        b=On8aHhSjJJUiGHFTMSiskSRJPdD9m6qKidaLZiEY3fMR1ZZGxtnZk6AAKwTUXMh/bT
         uL0Vpo1AAYp9N91ouiELeFVxIqNOsX1ByI0OQfPxux1oD6YFIP5uBhjCCrl5qCZuenYY
         G8mZO+WPK56igo/uyExmu3w7mXaTCsuw6x7YF88VAW3vCNHJzM8Dg6J1867sLLtXcbBu
         mbUiQ0QD3gsTwsh0Ph67YOSCRbHsLeqzIW3uUhY+Zyxo9fPAw55c3ksH6Qig2lwfJc1e
         9J672WFucCr+GQ9V9iVV44ZmXHuhZvtvoViXSCRWn0lxVcKTW+f9ZKUfItw1lfQJ6NHe
         DRyA==
X-Gm-Message-State: AAQBX9e/x0jt2Uqe8xw2pNBqOZzxjYsvXjhyGrF6VI5BWvo09hC5tbPK
        uLFvNrohTeMx4PgZ/VwvSlw3Yw==
X-Google-Smtp-Source: AKy350aso6IEsDAN1exazMbmo6Wh+kHtNe004GaFkMaSD4/1/07yu0c9ScNQNbT2abH6NzKDCzhu7g==
X-Received: by 2002:a81:a210:0:b0:54e:ffbd:7a7e with SMTP id w16-20020a81a210000000b0054effbd7a7emr13157859ywg.45.1681674716340;
        Sun, 16 Apr 2023 12:51:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 22-20020a810b16000000b0054fae5ed408sm2677063ywl.45.2023.04.16.12.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:51:55 -0700 (PDT)
Date:   Sun, 16 Apr 2023 12:51:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Zi Yan <ziy@nvidia.com>
cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 6/7] mm: truncate: split huge page cache page to a
 non-zero order if possible.
In-Reply-To: <9dd96da-efa2-5123-20d4-4992136ef3ad@google.com>
Message-ID: <86864d6c-39d3-d26f-278f-b96e14884541@google.com>
References: <20230403201839.4097845-1-zi.yan@sent.com> <20230403201839.4097845-7-zi.yan@sent.com> <9dd96da-efa2-5123-20d4-4992136ef3ad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> As this code stands, truncate a 2M huge page at 1M and you get two 1M
> pieces (one then discarded) - nice; but truncate it at 1M+1 and you get
> lots of order 2 (forced up from 1) pieces.  Seems weird, and not worth
> the effort.

I've probably said that wrong: truncate at 1M+1 and you'd get lots of
order 0 pieces.

Hugh
