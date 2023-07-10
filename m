Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB97874DFD3
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 22:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjGJUvU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjGJUvB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 16:51:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B02720;
        Mon, 10 Jul 2023 13:48:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686ef86110so2620658b3a.2;
        Mon, 10 Jul 2023 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689022074; x=1691614074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYfYEgruayK9dexrYha0GdoxGIRikS6sxUciqhG4Qug=;
        b=fyOST0vDrhBJq00W+LmsNke8ozMtF0Se8rBJWw4JfK0vMMI7TNm7wYtbHLx+Kg6npg
         /LZewepSK2hN9JNyTN3Z5s/afuJZIt6EQ9W8rMr0pFJ2X5hZHnCpV6v5o2RrOI6aQ/++
         ju4v9VPbHVmRvYeFYbg+OPt4k19azTSyN2Bv8+jdjN8cv9FY8eeLUmcZuFoMEL4/goXj
         rbst0fqlGHUtPIJ6MGFhJc2QtCWC3tzVSO5dk6IYVG1y3C1xg+0fwwxv42+LUMScv7XN
         2Rz9RDWAYiXWsV0eeqQkmzi19vHUGaZC4Uz6iyxx5+g3t1faCh2WHe3Rsh19aPRhRyBM
         3cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689022074; x=1691614074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYfYEgruayK9dexrYha0GdoxGIRikS6sxUciqhG4Qug=;
        b=YkaOV/OpbiwmA0aaoTBlJmfx12o5rioImChSbQtdKUlmAvPdaBooGScbAQQDyDDqhv
         Smim9D3k6Rp+R/Pf4SpYQ/cjioOU9DK77k1L0eUjpYDASsUIhTPaT19axSZ2D5Cxf7r1
         nj8CH0+w2RSZ8inXN5yBoIYxMZhdu0jwj6RNQsqR2z7lYJ5cEdaEE6McAtR+uKD5JrQY
         OmqIimXVRXENwpw7NNFFj13lL8ALXM7zj+jBw38P3OTRKFxJ2ruzJIJJWbeISQmq0nOj
         G/0PMVQcgcdaEiZice3dcH8LrQNhjYU7qni8M7lbk4rxwu5k7k2KqdG74Neyr2ivIjnM
         eOyg==
X-Gm-Message-State: ABy/qLaFO0m+axK4ao5fBdrgcEAwb9TSIfYu4qq0lvIaDixArrJHS1sZ
        RCCAwjG/m50RA+yKj12LJPA=
X-Google-Smtp-Source: APBJJlHkgRCC+nrutiGrmo0yaYyeLLF1IRn/OVHUr8sd6KM6fC2n2eXgaBym6M+G5U+jvLYRLWP1tA==
X-Received: by 2002:a05:6a20:431a:b0:111:ee3b:59b1 with SMTP id h26-20020a056a20431a00b00111ee3b59b1mr13845699pzk.2.1689022073961;
        Mon, 10 Jul 2023 13:47:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b001b5640a8878sm307019plk.180.2023.07.10.13.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:47:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:47:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix obsolete comment above for_each_css()
Message-ID: <ZKxueJGs6ZSgOWWV@slm.duckdns.org>
References: <20230627114059.1310936-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627114059.1310936-1-linmiaohe@huawei.com>
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

On Tue, Jun 27, 2023 at 07:40:59PM +0800, Miaohe Lin wrote:
> cgroup_tree_mutex is removed since commit 8353da1f91f1 ("cgroup: remove
> cgroup_tree_mutex"), update corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
