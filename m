Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1176D7EB
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjHBTgu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 15:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjHBTgt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 15:36:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ACF272A;
        Wed,  2 Aug 2023 12:36:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68336d06620so140720b3a.1;
        Wed, 02 Aug 2023 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691005006; x=1691609806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwvIHK2FntGoMwY6+ktOdJ0iSpGWmfPz9OaqA6nqQMA=;
        b=fWFpdXo3X7T77St6fMoMfYSA6kgUoa6yDMZruNO4apxP086MfZNIZ7S9R/Cm0p/srm
         Lo009Ee26Se427vu5jcnCdo5KYB42534jWdlsa0TtJrgC6dOlSVfFsc9d0P09EVubWpP
         cd9g9bcwIeBSJjnVn0GocsO/fojG9LHBrO30GmW+LRRpe2cCZ0qxxSr84neXhjJS7IJo
         f4Pu0WT8TleEjuJIhVuwkfFmBLw5mLbCaUprwFYjdjq7C52IVa1FKjTzGG8UFIU1DO7f
         BkKUu7OrLlsAIZSh1jwiz1JXgf3/4/HefbHcxHjgTblVZ8MF+2pj6VrBSLDZNWp5qvX6
         M8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005006; x=1691609806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwvIHK2FntGoMwY6+ktOdJ0iSpGWmfPz9OaqA6nqQMA=;
        b=fKfGZAoGD/tbTuwPq8F3dldDsr4g2AYtBRfWxBUEejqDO8oRbOJhGi3ollK07BX/KF
         rzGFdJaOO67ptZ4o/NW7bLix8VmItyjKUv6Ut1Jk7IlMpiXvcoUskYZ5kkbPi/+pvX9u
         1jso+RA01+ySKxugPQeh4t0O0yXLgwsuwd5H4C0sUpV21MmKeIs/s+q2N0E4St2S6mNc
         K1SrUuAuC60qAR2fjPDojsgPBQ6I9h936H/xrDSfPicPo+0Bs2Hs6Cx8eU9ofA8RgxoU
         S5UKp9rO9kIKyRU04lz6+FgfiIdRkeI7EXqFsxuNaHEvtkBp6vweBilNGMzDqYrFmLlM
         Z71A==
X-Gm-Message-State: ABy/qLY9EVLK3BZWidlWz1ZhQJMHVYHKXeo+JMtRH8es19OjojmQOb9Z
        MudOAuYXnBNRlE2R7Hb8ul8=
X-Google-Smtp-Source: APBJJlHNAz3HNuy9nwKkJKkRK19JIIG6NrPZ11wHAAiKjL5tpCfmJ6BsnrMGhpt/wYDUzuBeJqea1A==
X-Received: by 2002:a05:6a20:8e18:b0:13e:90aa:8c71 with SMTP id y24-20020a056a208e1800b0013e90aa8c71mr6997502pzj.45.1691005006241;
        Wed, 02 Aug 2023 12:36:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id n6-20020a63b446000000b00528513c6bbcsm10891861pgu.28.2023.08.02.12.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:36:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Aug 2023 09:36:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: clean up printk()
Message-ID: <ZMqwTLAYE9OMNLlS@slm.duckdns.org>
References: <20230801072217.103554-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801072217.103554-1-kamalesh.babulal@oracle.com>
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

On Tue, Aug 01, 2023 at 12:52:14PM +0530, Kamalesh Babulal wrote:
> Convert the only printk() to use pr_*() helper. No functional change.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
