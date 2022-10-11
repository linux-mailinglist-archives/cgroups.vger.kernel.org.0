Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A55FB89F
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJKQxu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 12:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJKQxs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 12:53:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BDDA3F57;
        Tue, 11 Oct 2022 09:53:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f23so13764635plr.6;
        Tue, 11 Oct 2022 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wl7v0z/p2+wB3apqHXeEZNHFFTX3kIYffMColIWffT4=;
        b=fe9y9dV32MzYVl0l8UVUS8Nj2Bn70r5r10DWr7jOsP0TeSUOxZa+q76FX1JAVBQx9A
         hTfwFLFpIZoms5zYBD+LZIRt2hQyqBNFctK7hSdkYml+sHmni/CuBHZs2Ywuk3GXMtu+
         4ZCQ1KznO3DwI1RWztd9HrO7W4wV2BYgGsd+ThrzhwHVy0wszz5wyd6u4T9MnSp5C3jt
         p58v8Rj31jStYBgi+gZxnp0MpIGMPmfLa9JIgfSel3+e0V1veCoP2iG+7EBat2nCyT0c
         nPadT3RqSqvFqGN5xlcgP9v19d0kVjfZTUxj3ME9IU6wKL14bhjgh8CIgtIPQsHY3HZe
         xzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wl7v0z/p2+wB3apqHXeEZNHFFTX3kIYffMColIWffT4=;
        b=vUCHG+LKjKdt4jkReck7bXyHaOUS00OMe2S+ILeB857H3HDXNwaEMMeiF5hWnMatb7
         jV5BCxxG8pwhaohMDrOeP+tnLi2B1zI5mQbCDlZrv4KVqhVQt6aH3Y7ZI5ceH8J6YPDT
         mKK2xh9F1dG76WqpMPEeCTKnJKw42ljk4I+FERpKQy5WeKpZt2AIgpr4X2A/+jS9EvW7
         bjw7xSQC4+POIsPDpCMYfUoAjkyyRIEyE3kFf57w+gzyFloIZ/8kpAK5SaETIMmR8ywL
         qNzUElfaNkRACqYRjg7aLqYcJzDLoLNUAOMi5oyFwGjrqX4Z5gB4XEVRzVP3+/HXMj5Z
         wMNQ==
X-Gm-Message-State: ACrzQf3o5+SpYgd29EaYeZJxtxJeqk6p2HVubNeOAduKFALIfJRRJ/5R
        NqFaZZ1QXtnpRHAeWZxHAKMKbUirhE/lPw==
X-Google-Smtp-Source: AMsMyM5PhzyKeKBO55Ip9T86YF+e5puzCfA8YOku5QqsvjDP9EYDNNHA2tU31d/Rxdk9HGN8kNEzkA==
X-Received: by 2002:a17:90b:3ecc:b0:205:e177:fa2b with SMTP id rm12-20020a17090b3ecc00b00205e177fa2bmr63435pjb.124.1665507224983;
        Tue, 11 Oct 2022 09:53:44 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b0017f8edd3d8asm4070082plf.177.2022.10.11.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:53:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 06:53:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] perf stat: Support old kernels for bperf cgroup
 counting
Message-ID: <Y0Wfl88objrECjSo@slm.duckdns.org>
References: <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
 <20221011052808.282394-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011052808.282394-1-namhyung@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 10, 2022 at 10:28:08PM -0700, Namhyung Kim wrote:
> The recent change in the cgroup will break the backward compatiblity in
> the BPF program.  It should support both old and new kernels using BPF
> CO-RE technique.
> 
> Like the task_struct->__state handling in the offcpu analysis, we can
> check the field name in the cgroup struct.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Applied to cgroup/for-6.1-fixes.

Thanks.

-- 
tejun
