Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0628642CE5
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiLEQd0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 11:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiLEQdJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 11:33:09 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B25B55B1
        for <cgroups@vger.kernel.org>; Mon,  5 Dec 2022 08:32:53 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id i186so3000358ybc.9
        for <cgroups@vger.kernel.org>; Mon, 05 Dec 2022 08:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0PmNCTsJvxvDZkgjesfJCZeYmU+d2L5HAvI1G9E1wU0=;
        b=hzi9C2SeIoAe+8utJLZkRl5OJn8tSGX5qRPD5dh4gB67VBShqwIDTtup25L/ShHWq4
         qE99izmvwdghDESkJxAEZVDQqVAUXiGaOg+BVzXwAkOozxt05+d6ov0t8NR89LqGpHJs
         sT/jcL0n+bxPA6MtVxnvQqAmqaCYBGCRxm7RP9wQ2vRvrjVQw5bWZ2kfj9zp4ynkX0hF
         Z2rwttKysXQ9yS6wDqKBrbxtBtNhQQnKRpt9wCxXC46S8KCE0rTYBJ7+2tiadJK9I2lL
         wMkz3XnzixqIWhd+TYYxxy3EimRctwyVS5KqOwqMx7COrCbXii8SmsLtiTdmAtSebfDH
         uZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PmNCTsJvxvDZkgjesfJCZeYmU+d2L5HAvI1G9E1wU0=;
        b=7wLgDTI2JOHFZKbY67+SPOJO3SH2Bo9H6Rdflp5btFPyxwLkoKHER3Uwoq2+ahLYP6
         +xmWZ37TjjoOOtz7YEIJuL9po56THXiWEvOLU7eADpqexIzObn/tqHvrGKo/sYFyayiv
         rdEebDN8kXka4c+vbWZ8+phBp4sC0DRHocrJvJumMcRt0meS7Ly8HI1O/JF1gu3ZZPMo
         ATNIonPYxBWI9YEZwXS5Gno3SWiXFgh7ckuTkgVjFc7o6jpHQeZ0AmqZaGikfS+MbEuR
         819WDTSSikm85oF8nYQqocYKlxZ19jVwsfQDzoefYLlE4wjeYQFQBx/fCRoAUITWldJK
         FEmQ==
X-Gm-Message-State: ANoB5pnuRVYmNrd1so+VnmmeSVbT7lEJCViTohLDCU8KeilQj3lNGG+b
        Foj0cQTOWUygbmK4YSxpTrRgKZlrnkpmvwtTw8Z45g==
X-Google-Smtp-Source: AA0mqf5QrOt5v9YAkGO2WKSJbivWEkXF2C2N7cBf4Sgn8LSjlWrETqQGJ4eC1TtopP/0rIqAvDxH+tVCYmRtCJgdNfM=
X-Received: by 2002:a25:ae92:0:b0:6f9:d605:9f6a with SMTP id
 b18-20020a25ae92000000b006f9d6059f6amr27394119ybj.294.1670257972458; Mon, 05
 Dec 2022 08:32:52 -0800 (PST)
MIME-Version: 1.0
References: <1670240992-28563-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1670240992-28563-1-git-send-email-lirongqing@baidu.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 5 Dec 2022 08:32:41 -0800
Message-ID: <CALvZod7_1oq1D73EKJHG1zQpeUp+QTPHmMRsL3Ka0f6XUfO4Eg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: speedup memory cgroup resize
To:     lirongqing@baidu.com
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 5, 2022 at 3:49 AM <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> when resize memory cgroup, avoid to free memory cgroup page
> one by one, and try to free needed number pages once
>

It's not really one by one but SWAP_CLUSTER_MAX. Also can you share
some experiment results on how much this patch is improving setting
limits?
