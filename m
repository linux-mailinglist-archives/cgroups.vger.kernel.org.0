Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039A7A5271
	for <lists+cgroups@lfdr.de>; Mon, 18 Sep 2023 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjIRS6Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Sep 2023 14:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjIRS6Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Sep 2023 14:58:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA9111;
        Mon, 18 Sep 2023 11:58:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso3725491b3a.1;
        Mon, 18 Sep 2023 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695063497; x=1695668297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIq/dcnUlfz9c9ZMg9REc9/bKulrunuVIS2q81WpsmA=;
        b=FRRbTfPlWZTj5JCf6cVkzU6C/btoGlKTDH7qt519WzjunsWS8crRO4CGourmoCqM5O
         ts75zeEZ9f7qzcgOGpV2OnMNTK/GEjBj5iBUOhxjRLosOP7147EOjWu62h4Q0jJuc4Fu
         /da2rLEPR9VetBkML9Y3Bo+Lvy3AiDIPN/pXTNHZMTps81DSYEiyGlY58mNObieXYKw5
         8pcu9wliAhCi5vonpL71cqdmEYAEVeD7BtP87e+gBg69cOlWpqU4tOT0737bbPmPdHYp
         oaKAK4VPRQsGVycskKMFVw6g5kjNnuThcbpYJX+28qTsZl5NuS7BtIj/RqxHt5rdM/5N
         xJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063497; x=1695668297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIq/dcnUlfz9c9ZMg9REc9/bKulrunuVIS2q81WpsmA=;
        b=qf6FwQOfDvQIoeAIPj4Jb3cCBfCJFgYEN+hs/6Kq73/NdpPsLEb0sET/53Wb7zh0iE
         4Gt58kW0nX8ir2zKvG9gb2fi5NizLxXYbi9ajPSTNKGVg5Vt4gAe4G7TyO8FqIUwOCpF
         mQePYT4O8Jigq6ffvP4uFxI+9yPuieAFXIrnod2piGL0NZFAgmBtIn+YPMJS1LbZr1q1
         EQB6V+JmkgvaPhK/iYhqKVZfK1IrHbR6ThIxAUmMkwOr/tq/571bt9RWTKoD32/gjfdQ
         a2XEiwPpLUm82ho5lnq/XH2dg9V9BnoZ9n52fqe6krq2kbsxwBs1o2X+zxN/CHkZvTv8
         B3PQ==
X-Gm-Message-State: AOJu0Yy3sn0ayPxroYih/v4HWHbdXdG3dzZGwnofBx9A0fcl0wCWbdlv
        fBm0wEZNTiqWqFzlk6y9Rvo=
X-Google-Smtp-Source: AGHT+IGIa8qRSXOWAZ3XsAwwqi6c1pkqrcbYKLWulCnPW3fjdPdeJfF+xnLZ8JHOnSyFJ2OAM9+jpg==
X-Received: by 2002:a05:6a00:1588:b0:68c:4e22:8f78 with SMTP id u8-20020a056a00158800b0068c4e228f78mr9961940pfk.25.1695063496647;
        Mon, 18 Sep 2023 11:58:16 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id s14-20020a63924e000000b0057825bd3448sm5327721pgn.51.2023.09.18.11.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:58:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:58:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup: Avoid extra dereference in css_populate_dir()
Message-ID: <ZQidx8_nMRsQVtwx@slm.duckdns.org>
References: <96694dfc5f4caf4d84a740c3b18b0a456c9ff522.1694501024.git.kamalesh.babulal@oracle.com>
 <5870fc2459d97b2e47c5a8dc47f1a2a3837c5e03.1694501024.git.kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5870fc2459d97b2e47c5a8dc47f1a2a3837c5e03.1694501024.git.kamalesh.babulal@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 12, 2023 at 12:34:35PM +0530, Kamalesh Babulal wrote:
> Use css directly instead of dereferencing it from &cgroup->self, while
> adding the cgroup v2 cft base and psi files in css_populate_dir(). Both
> points to the same css, when css->ss is NULL, this avoids extra deferences
> and makes code consistent in usage across the function.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied to cgroup/for-6.7.

Thanks.

-- 
tejun
