Return-Path: <cgroups+bounces-767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1C8011D8
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 18:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B392B210D0
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705C4E611;
	Fri,  1 Dec 2023 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC9qF94r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A71210D;
	Fri,  1 Dec 2023 09:38:21 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d069b1d127so2013455ad.0;
        Fri, 01 Dec 2023 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701452300; x=1702057100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxYKYxa2f3h1gY5ZKTN+p7OrPj0aJycT2sfyeld/5kI=;
        b=eC9qF94rbF/LaeL4waMYHM8R8w1X0LczMfIwoEwIJXWWKVMQ1iiKJcjfiB3vHB120I
         2vFagx7MO6EOD/Y0hbWH+PbxweWUObUFHo6ogVyDAWwXeL/6M14jGZfx9adN0EHDJEB8
         pZZVy6e7JwuSYuH2Io2cUwWs2KE7eIfYltGMAcKKytaHHc3A79Rvqm8xeZ2Q/7OhcwQK
         +ruqilmXNAkMH/3MVtSbqho5UadPt/XR4Kqe6VAPmVUBov/TXxksq9ret8XT4lZioJTh
         Wfb52gAXFoBYdFbugrAZ+amc0n+VuSl50BFYXSLowE6E7d+7EaxLCQXP0gLA4u+O+Ror
         3qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452300; x=1702057100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxYKYxa2f3h1gY5ZKTN+p7OrPj0aJycT2sfyeld/5kI=;
        b=xKbLSYWjJxlDx1lzZZZBTw9AZgRHVPiAN399mRTxOXW+idY9EQHyFWaqT+DPP4LWZ4
         ovnSqMfHhfDuHw0k6dAcPxGeEsyQMvD4dPfii/CRX1N9rZgIZI5NsjAUIxZ76ppTN0PA
         7E2ZIWoGaQgF8E2yX3SJf+0nOqr1G+4UrJ2vqqNpFl26YQ24DRs6drtIyUvOXL96pYnl
         7lNp22XYwrtHFJG5RMi7XJPNffARY5mswknFQw3VEYCbsb+TWvYRCyto0ofx6/IC/jGR
         O3q9nFu+U1RVxVyozP9wNUBTsYVH/vIGq/lMD4eM4inHK8C0HsDukJRDlKyEWR1IYfwb
         Kttw==
X-Gm-Message-State: AOJu0YyA0ajDHs8d24Kr0Z3zbqFCOLIkW1hXRlTqOhatIfmSvROv94Zo
	3SiGbImixV4aWSEE1ffig8U=
X-Google-Smtp-Source: AGHT+IF4YmWAjkFOtoLBTl4basnTlq/DN9rOIfUuaKQlouaFHMaNPw9rJfnjK5rwDLx96fSGIuCqVw==
X-Received: by 2002:a17:902:a9c2:b0:1cf:c681:39d7 with SMTP id b2-20020a170902a9c200b001cfc68139d7mr16287720plr.38.1701452300433;
        Fri, 01 Dec 2023 09:38:20 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902864100b001cf51972586sm3563766plt.292.2023.12.01.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:38:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 1 Dec 2023 07:38:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH-cgroup v5 2/2] cgroup: Avoid false cacheline sharing of
 read mostly rstat_cpu
Message-ID: <ZWoaCtcrciXpTEPH@slm.duckdns.org>
References: <20231130204327.494249-1-longman@redhat.com>
 <20231130204327.494249-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130204327.494249-3-longman@redhat.com>

On Thu, Nov 30, 2023 at 03:43:27PM -0500, Waiman Long wrote:
> The rstat_cpu and also rstat_css_list of the cgroup structure are read
> mostly variables. However, they may share the same cacheline as the
> subsequent rstat_flush_next and *bstat variables which can be updated
> frequently.  That will slow down the cgroup_rstat_cpu() call which is
> called pretty frequently in the rstat code. Add a CACHELINE_PADDING()
> line in between them to avoid false cacheline sharing.
> 
> A parallel kernel build on a 2-socket x86-64 server is used as the
> benchmarking tool for measuring the lock hold time. Below were the lock
> hold time frequency distribution before and after the patch:
> 
>       Run time        Before patch       After patch
>       --------        ------------       -----------
>        0-01 us         9,928,562          9,820,428
>       01-05 us           110,151             50,935
>       05-10 us               270                 93
>       10-15 us               273                146
>       15-20 us               135                 76
>       20-25 us                 0                  2
>       25-30 us                 1                  0
> 
> It can be seen that the patch further pushes the lock hold time towards
> the lower end.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun

