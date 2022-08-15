Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00435929E5
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiHOGxf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbiHOGxe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 02:53:34 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CBC1BE9A
        for <cgroups@vger.kernel.org>; Sun, 14 Aug 2022 23:53:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 64so8020053ybl.9
        for <cgroups@vger.kernel.org>; Sun, 14 Aug 2022 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sT4Rmwp/q5F6bitQkSvyQ2IGtxsYD4gW1e3lvIrc3So=;
        b=PVJGB1kcTWLqtneoLcup/71OtYkgR6MTfpwPXChMx16SRUlh5drf3L+XQBVfhjiuhU
         ifoO/2Vx5JHkemKtOE+ubS2DzUUOol+0GczZXNhXIr/DQG63Z9YfqgL9Sx/rMqyNuduS
         6UlgvfmzRAqjqU1t0k8lTka3QS743t3FmMdgO4fgTHBSZtBG4Z95Zr6tu4TU24+lH7pY
         RKTtyfFcJMR3GzuC1N5LgJMKyqp6rcsk23rIMe2l91ptRsZU+ERpVo+jh3DaWygkyzoP
         qUSlE/N7wSFGgKtKWQKex/PWfIegJ3u4SCSMju5+9S8vF6cjHLkaZGzXjVNIVgfOdBGk
         BfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sT4Rmwp/q5F6bitQkSvyQ2IGtxsYD4gW1e3lvIrc3So=;
        b=IROosFfz/+llHcBLbc9x/j/CwNGhNvNk0itvzjJZ39uAnzMagv3hCVZ6wkNmTTK9SI
         yxLqEGL3MLF+akN3SxCuwRBLo+pGxdvbhSZ3nbJrGq8HbM/+GXAOsirHte8F59M1KTnj
         FTtQqC4Dw5bmV29PaVYIBaQ/7u85JGrATVpqt1bN+mTelWydNvzJBvSZ3g5yptP8Xz93
         k9Iyn0Zb9bHiBalygS3l+/UVRkdrG1VflCIvUx0QyC70MQIdUIo3lWPyYXjsVfgKhCKs
         487cxXoPvWQsg9Ea0UafQFxPDdDB/9iArs5ATxIaQHWOGf+lDs+Ztd51ipFfWcvOEIfN
         FgTw==
X-Gm-Message-State: ACgBeo1/CNh2N0BOLIKWXCwZRFrcN9UMSceEvSsNvmgnW7D1RzJQSqoo
        M8Ks1Cpp/+6d0Qrg6fuvD8KKA+wrV98G23AspnPEMPjp6xREFGjC
X-Google-Smtp-Source: AA6agR52HmNM/t4HOkP9haOpcbcHC2M4sJ/Rx0X7wWhxzsNFERuWHgZ9SKAqn511srRD8c3TL+if5O/4y6cT+H39M7c=
X-Received: by 2002:a05:6902:1007:b0:677:84d:61d5 with SMTP id
 w7-20020a056902100700b00677084d61d5mr10638354ybt.46.1660546412362; Sun, 14
 Aug 2022 23:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220811081913.102770-1-liliguang@baidu.com>
In-Reply-To: <20220811081913.102770-1-liliguang@baidu.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Aug 2022 14:52:56 +0800
Message-ID: <CAMZfGtViCehvPoADMZs-ceo3fnGU=_3vNu2i6tywGq0Cpt2meg@mail.gmail.com>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
To:     liliguang <liliguang@baidu.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 11, 2022 at 4:19 PM liliguang <liliguang@baidu.com> wrote:
>
> From: Li Liguang <liliguang@baidu.com>
>
> Kswapd will reclaim memory when memory pressure is high, the
> annonymous memory will be compressed and stored in the zpool
> if zswap is enabled. The memcg_kmem_bypass() in
> get_obj_cgroup_from_page() will bypass the kernel thread and
> cause the compressed memory not charged to its memory cgroup.
>
> Remove the memcg_kmem_bypass() and properly charge compressed
> memory to its corresponding memory cgroup.
>
> Signed-off-by: Li Liguang <liliguang@baidu.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
