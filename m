Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087F07AB67B
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIVQw1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIVQw1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 12:52:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD242A1;
        Fri, 22 Sep 2023 09:52:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso2052448b3a.2;
        Fri, 22 Sep 2023 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695401541; x=1696006341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seU9shViMhY31gmIUtGee7cdWlwMOHkiBVOkqV5wiBM=;
        b=no5DHhq49rd/cEV4zYOSrQFvbA+lx6OEZ6f7pjPCjFrrxZlba1YNgeTV3dZs3eTOOx
         GfhwRhK80sR0yfIwpS0J+8Ib7TDqsQS3hb/9bdtc9/7+0JIi5rGoncK1ZS76JOIqC7KD
         6pfjnSBMV4E/14ToJfZ4GJY5R3HLKYrVQXOl5mvsIWEScBrKs/iz3ll+Q0g52L3NsbTm
         X3XKlSQ/9sjkFFWbGlKqvIbweUY9XNy+M+BwzoRYi7YJsBoCb0dMUdvZ6ABpAO2QEAnR
         me37/3+ev9zbmEVPpgyhzGvO5cwaeYWt3+pcZ7jX2XddYPeAS5/vt8JbVPL3RpyyhIKg
         lxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695401541; x=1696006341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seU9shViMhY31gmIUtGee7cdWlwMOHkiBVOkqV5wiBM=;
        b=Trk5Mvar+otl6FCkDeBMeluvoMBZpHDF8DUcmvjMWEsM+Vo7uqxrh+qdsAWa6OG7IC
         PSGdSl2uw9soHQWEnj6AvmKnwzmJnZTGMu8lAUMFYwACH6HrMZ1Ywlv6xZafqGC2Xigs
         Mo8/tZdienlMbPeSLW0TUPIEzDVtas6aCVtPuPIOqYDvRMCVAoNYM6YQRqTgUEFoXDPb
         cvkJJWXms8TW1F2h6XLnRfdHAakt16FcP9dO/JuOmaO8EZOa6EVIilpDiPfkFwGRc0CF
         4TMZN4ubaAWjAjoCzd8ERa4SurSmehkS2/EE3yj/c8QkO3sHZsz2U7IMAX4xI3MFGO+n
         PSPQ==
X-Gm-Message-State: AOJu0YxKR8O/BjINCVxk+OcDUJAr7BvDJe2bL2o2M/RIjBmwcoLzi+6n
        h4gLRwpQAP8+VQGLorNv4V0=
X-Google-Smtp-Source: AGHT+IFgNttt+D5N2k8xcf3a47SYxXfmKp+PPweopf4an7DEEEliP0OwekRzVrGSvr4cJz9P7JkgUA==
X-Received: by 2002:a05:6a20:96d7:b0:14c:d5d8:9fed with SMTP id hq23-20020a056a2096d700b0014cd5d89fedmr82830pzc.54.1695401541087;
        Fri, 22 Sep 2023 09:52:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:dfcd])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b006877ec47f82sm3430530pfu.66.2023.09.22.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:52:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Sep 2023 06:52:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup
 controller
Message-ID: <ZQ3GQmYrYyKAg2uK@slm.duckdns.org>
References: <20230922112846.4265-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922112846.4265-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 22, 2023 at 11:28:38AM +0000, Yafang Shao wrote:
> - bpf_cgroup_id_from_task_within_controller
>   Retrieves the cgroup ID from a task within a specific cgroup controller.
> - bpf_cgroup_acquire_from_id_within_controller
>   Acquires the cgroup from a cgroup ID within a specific cgroup controller.
> - bpf_cgroup_ancestor_id_from_task_within_controller
>   Retrieves the ancestor cgroup ID from a task within a specific cgroup
>   controller.
> 
> The advantage of these new BPF kfuncs is their ability to abstract away the
> complexities of cgroup hierarchies, irrespective of whether they involve
> cgroup1 or cgroup2.

I'm afraid this is more likely to bring the unnecessary complexities of
cgroup1 into cgroup2.

> In the future, we may expand controller-based support to other BPF
> functionalities, such as bpf_cgrp_storage, the attachment and detachment
> of cgroups, skb_under_cgroup, and more.

I'm okay with minor / trivial quality of life improvements to cgroup1 but
this goes much beyond that and is starting to complications to cgroup2
users, which I think is a pretty bad idea long term. I'm afraid I'm gonna
have to nack this approach.

Thanks.

-- 
tejun
