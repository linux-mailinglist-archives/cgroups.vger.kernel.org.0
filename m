Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7067BC8EB
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjJGPum (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbjJGPul (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 11:50:41 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF9BF;
        Sat,  7 Oct 2023 08:50:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3af604c3f8fso2098734b6e.1;
        Sat, 07 Oct 2023 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696693840; x=1697298640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRb4xyVggbiNdF/CuWm/83mjhA2PGKIdFUSg0RWfnOE=;
        b=NVc0hYUUBqTebhXu5sTTZTz9hNNpT7vy+t73CmmHG1D/fIBDRsQGl7zMjQ0XfnLff8
         Y/vWbrZaiecPfW24b1R3e8cbmv0r0pvkp/8eZu7Gt5sbBw1c+Y59elP0zpb7qp3wyXIz
         dqKnUwOGYBpmQlLJevqNHjTd2cIF39v7FpURQJLeWA5tb2RwkDG+IwSdkqwHE2zmFjFX
         iehEWtviuK3UPD1vx8WvanKYCkzEoQH/tzSxb15gzeduQlyYIab/OVz1QJN4Igg9WV6H
         3t9mBL1Vz4Niuh9761lm4wmaLgvw1Ka5WKVzYGn8nmPVsZ2+k9nnB9tQcxvdmVPYGYKC
         5Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696693840; x=1697298640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRb4xyVggbiNdF/CuWm/83mjhA2PGKIdFUSg0RWfnOE=;
        b=dsTn788J/CoHMCk5p7SDXxemyk+n7+l5NQ4MqaDDjwcxL/Bxd0sT/c31Lv5h0SxTut
         L7MjBos9N3QtxKAbz5f0mhVqKen3mYjtQ9wAWfnga+Pjmsw/+0tE757MNLQO4BR9LIUd
         PwYFyRYWrVjSHQCGNK7/2ttPkC4XgPHPfCYKVXwcuH1QH1wXeVRc1dhqbQ6ioIhFP/T7
         kRzbY2KZx0iw2qv2pw6RATJJC79l7hR1oCe3WFvVxVFEQpWUdq87cEm1rgFNftZTjXfo
         07FqFlTQQ4YJ7ICi3UilbQZqj3sFVORSZ6p5JAue07PFbXaHTtZIvevMQbnrdG1xtug6
         cE6A==
X-Gm-Message-State: AOJu0YzUASP+ae1A6sXz7UtNMYZmN1uXWPD6DtT6Pv520igWNwPuli72
        6Vd8nbEQvxJU91C744TQJfE=
X-Google-Smtp-Source: AGHT+IGKDslXMsVHZ8g50T+5zfWAxU0NHbnVre1UM1pKyhAb/W4tJK9zhKPyMcfFooUpuTTGNyvT6A==
X-Received: by 2002:a05:6358:988d:b0:143:723:8f89 with SMTP id q13-20020a056358988d00b0014307238f89mr13481795rwa.4.1696693840007;
        Sat, 07 Oct 2023 08:50:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b00256799877ffsm5313614pjw.47.2023.10.07.08.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 08:50:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 7 Oct 2023 05:50:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/8] cgroup: Don't have to hold cgroup_mutex
 in task_cgroup_from_root()
Message-ID: <ZSF-TeyAxq6xqcII@slm.duckdns.org>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
 <20231007140304.4390-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007140304.4390-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 07, 2023 at 02:02:57PM +0000, Yafang Shao wrote:
> The task cannot modify cgroups if we have already acquired the
> css_set_lock, thus eliminating the need to hold the cgroup_mutex. Following
> this change, task_cgroup_from_root() can be employed in non-sleepable contexts.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Maybe just drop lockdep_assert_held(&cgroup_mutex) from
cset_cgroup_from_root()?

Thanks.

-- 
tejun
