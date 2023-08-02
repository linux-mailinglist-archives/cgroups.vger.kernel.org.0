Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5B76D80A
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjHBTih (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHBTie (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 15:38:34 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256CF2D62;
        Wed,  2 Aug 2023 12:38:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bcade59b24so210694a34.0;
        Wed, 02 Aug 2023 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691005098; x=1691609898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGZYAlYoxklSxp+0rfvYKT0X2lcn2CrtNxj5gHKMWqA=;
        b=H0zyghXvQ6QELgoTQI+HxL9wqBt7AeShb9cF8ZMiw/lQylkQtm0H/HSEUj4pKWhh2h
         u0kT4xv3H1N4gK1NmInwfVo4wKJ5mWr91qAUSWmOUS5nYV5ecYeu2Om+UXNd9HWz/9bz
         q/N4nzhH9FfFMwm3keoxAHEqbZPBnqJzHx45ov/yuTM/IqL76srJaVFlYhi615OVj+zT
         D4TJC4mO0+Hpsr5sTrdC+4U8wM8bO08kAN97ct9yxJNEbsPYtpWkubXmJd9To4Xui21s
         IlMRw+pRB7Lfflz5zA65mx4reNkNpfgO85rBvLdTHd9tye8Y8RtOfNBAktja8ciuczGH
         23GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005098; x=1691609898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGZYAlYoxklSxp+0rfvYKT0X2lcn2CrtNxj5gHKMWqA=;
        b=Ez2HKYcgmPOlAthWYl2Zl1Sxqrt4prLGl+7QALG+WCNJRz3QpCCMElee0l0vQA7deI
         C7aug/aS2MCNhETXV1zsbyiWRKLECGAWzjlS07bdmU3HlxulXuKGse9eVrdiNY+PMcYo
         PuUZ62Z3SKoHz1B6kE6mIziLhMntYQdBlO+EPhzHu6Z+UlxENCe55g3TJP5aH//whutn
         lzyn6QxqRwZzUi0SaGSsO6b9mZ8sZGDepWWNw9JSeh6CA4nbLl2iYTgPyiT3Wlg07WjE
         zRGLLbRHpI8zEnrVno01t0vJy0LRtbG1cYZ9fYQzWOT0sVVZdk7GnKckYmCGupc49ntU
         gW2A==
X-Gm-Message-State: ABy/qLbMGjkW9l1/mAFzg+eOu/WVggEg4Zo/miOPAMjMjlQnQH3X0Yqx
        Uh3modc7G9S8j6mS8+iUtl8=
X-Google-Smtp-Source: APBJJlETxluvvBXdBxXg4cZEJLqWHe1+uiyQpatfYiD/4Pftz2VFEkEGtErn3+ycQ+KgRIOiy16KGg==
X-Received: by 2002:a05:6870:912b:b0:1b7:2879:a0e with SMTP id o43-20020a056870912b00b001b728790a0emr19899769oae.12.1691005098171;
        Wed, 02 Aug 2023 12:38:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a030900b00263dccf96a3sm1508759pje.54.2023.08.02.12.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:38:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Aug 2023 09:38:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix obsolete function name above
 css_free_rwork_fn()
Message-ID: <ZMqwqHhOkskbdqBR@slm.duckdns.org>
References: <20230801124034.2245419-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801124034.2245419-1-linmiaohe@huawei.com>
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

On Tue, Aug 01, 2023 at 08:40:34PM +0800, Miaohe Lin wrote:
> Since commit 8f36aaec9c92 ("cgroup: Use rcu_work instead of explicit rcu
> and work item"), css_free_work_fn has been renamed to css_free_rwork_fn.
> Update corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
