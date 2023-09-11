Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30E79BD1C
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 02:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377492AbjIKW0g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244417AbjIKU1t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 16:27:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D25185;
        Mon, 11 Sep 2023 13:27:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf7423ef3eso35417155ad.3;
        Mon, 11 Sep 2023 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694464064; x=1695068864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNnl2EUxq2zaX99R7tX9+iE5LFUxTKUThPqOegYIa5s=;
        b=i/kVnY717xMDqCNn3WYnViiOjjcMpjRZ3YDH8aw7uIBl6563xM8YlJRH0UUKIkzMnh
         Oy+VVJSeiQF17nUJj0keyWSm0EKkS064TuM65gKaN7cKXk+eDxX/f/PE9Mq659URYrHe
         xEkgSLA+Tf51xJozMHikNt7u5vqNY0lfOICQhaWYHi88CvK60oWo1gb1ggG49IBsOrsr
         I97r7rWLJyrFw3VLiX6JAeIb06R0U6ZHAoeLgqgUXnnBKcVOSzk6a/eFE9JBnEkHhCIm
         Ag6sSmOSPB8eLx6IT2BYVgPBkXm6hcCKZiUdcyOdAfD8z8xzunnGYF+heAxUmZMeWs4d
         Xy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694464064; x=1695068864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNnl2EUxq2zaX99R7tX9+iE5LFUxTKUThPqOegYIa5s=;
        b=GJr1bVNln4mEQkuKMtgrD9dpt5hvsd82mQEf2g7TtbTiiZStZYF1nQEU8L4Xg2AdNU
         6uecaGWKNVWf8Um07G7tGEQQdr+4S3v5WYGJ3YfVaP+TxEUMJST4cw/0IwWRQ40wnXyX
         cd9Ro6h5UCZ/Q9s0iyMmluu1ARNM4CWD15ukaUGraFnT2UpNpnMkuW6L8Y2YneZxDYwT
         jiTXXyLp5GtFMkR76nd2LT1KCg1QRKfgqtLGHEYXYsz5OBN3PqU6z4Yg03fV6Ex0P+wS
         i0GJZEIYGS0IRYo5gjLI1lTXCl9P98UQsZ15/o5DqIXQeP0/KDTbmXJOZtGbossxSuJS
         TjSw==
X-Gm-Message-State: AOJu0YymsTAogienNJIkhaQYwlx0FEjs5X0yIoNrLuTKjy45U7ib059O
        k+ptkZy1D7vIwPYpjyEWFapA8mWirVFdiA==
X-Google-Smtp-Source: AGHT+IGngHVyRdmTKS2TRrqK78EOerqzQ008OJjN7s8aS/kznDTkl0Gc09j8mylpOFyQkkxZWS+CFA==
X-Received: by 2002:a17:903:2302:b0:1bc:2c58:ad97 with SMTP id d2-20020a170903230200b001bc2c58ad97mr10290139plh.22.1694464064016;
        Mon, 11 Sep 2023 13:27:44 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902eb0c00b001bf574dd1fesm6835997plb.141.2023.09.11.13.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:27:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Sep 2023 10:27:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, cgroups@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/5] cgroup: Enable
 task_under_cgroup_hierarchy() on cgroup1
Message-ID: <ZP94Pqiz6PtUy_Ww@mtj.duckdns.org>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <20230903142800.3870-2-laoar.shao@gmail.com>
 <ZPjdc3IwX9gjXk_F@slm.duckdns.org>
 <CALOAHbA7gDFh5Bsr_99-rBa3h9dZw6ntF_+RxTjfK3yQXpYEFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbA7gDFh5Bsr_99-rBa3h9dZw6ntF_+RxTjfK3yQXpYEFA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 07, 2023 at 11:05:07AM +0800, Yafang Shao wrote:
> The fd-based cgroup interface plays a crucial role in BPF programs,
> particularly in components such as cgroup_iter, bpf_cgrp_storage, and
> cgroup_array maps, as well as in the attachment and detachment of
> cgroups.

Yeah, I know they're used. It's just that they are inferior identifiers from
cgroup's POV as they are ephemeral, can't easily be transferred across
process boundaries or persisted beyond the lifetime of the fd-owing process
or the cgroups which are being pointed to.

Thanks.

-- 
tejun
