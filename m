Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978CC628B8D
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 22:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiKNVqe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 16:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNVqd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 16:46:33 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A081172;
        Mon, 14 Nov 2022 13:46:33 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q1so11388490pgl.11;
        Mon, 14 Nov 2022 13:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taPjPZOHgyTR/UHrmegaCgYgAMt1HfCmx5v3wHZ6oYA=;
        b=miZ3R7+rKsoSQdxCi3ClLd+R+sUuBv/d8D2zNnsSp4J/0qqHSeLjg/OLOWIfJiAfiQ
         n513Q67ZtWC6tbiMUcMUbfGivhIsz0CXgn8fK5oeExaXDQo4V9SDU7V5Qeph7RV2U6M3
         ytc9B839D1XNiYJhj+SwxeJLv8k3lRK3dLgULbjX1G4LkXQFR8lSOJt25BSvDjF2jomY
         8NKF8vmuUK2gxuBKSmpKjz1npYJ1KtNxZV9jvbsTtOokF1iY4hUyJ0QaaZvzKeVRqdmc
         dk+oeWdeyP7iz5Y3MTNxtd8ji3ajB22mcyx7S/IBemIxWZ7Xfpr/iQPh9BvoFHD6de8R
         xbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taPjPZOHgyTR/UHrmegaCgYgAMt1HfCmx5v3wHZ6oYA=;
        b=vaDj1cz/JkXnAbCbFdB/AHVqqCmpXu8GnxXTtohEfs9gq92nMzMTtTQb9J/8dcRQOW
         /0FYlUijJhSijXXz8qFUwRro4jkry9JDCWv7OLTOsEAD+ASMDQ7oGieiTkKZcmllfN++
         Q+Yjn5noRzVQFX3vjxvjBY9abWdBWB+Gabphk1u6evtjp1j1Is3SNFGdTfPNP/ztm7kH
         ARDdZtELa/W7DzHhV2aTpRRmOu7lIUOt5vRoXQts0QsmcMQlHqudMTapl7nYEP8c6NGV
         na2bZzvm1hWKwMIe/iwVTp5eEiM3VvdKKQAN+WfIopb6qlWc6+4DPiyNj7jvB+dNeUyL
         JWaQ==
X-Gm-Message-State: ANoB5pn5nxXsoZWXEa1dkT14bruTwLVPQMqvYJTCWu2h07WbQWvbwZDv
        WMcX5nYBUvsXKfAnfiXtnzk=
X-Google-Smtp-Source: AA0mqf7oG5TT8ltViAb4ylRBnoKX3h+ZHHfzAm9O6tOLZtMwT5Fiyqp9ZMS46LINc87U5tBArRj/dg==
X-Received: by 2002:a05:6a00:244e:b0:56b:fb4f:3d7c with SMTP id d14-20020a056a00244e00b0056bfb4f3d7cmr15645046pfj.54.1668462392536;
        Mon, 14 Nov 2022 13:46:32 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b00186a8085382sm8045644plb.43.2022.11.14.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:46:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 11:46:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/2] cgroup/cpuset: v2 optimization
Message-ID: <Y3K3NoZkPecICr/Z@slm.duckdns.org>
References: <20221112221939.1272764-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112221939.1272764-1-longman@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 12, 2022 at 05:19:37PM -0500, Waiman Long wrote:
> This patchset contains 2 patches to optimize out unneeded works when
> running on a cgroup v2 environment.
> 
> Waiman Long (2):
>   cgroup/cpuset: Skip spread flags update on v2
>   cgroup/cpuset: Optimize cpuset_attach() on v2

Applied 1-2 to cgroup/for-6.2.

Thanks.

-- 
tejun
