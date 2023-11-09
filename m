Return-Path: <cgroups+bounces-294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA257E739C
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C41C20A4E
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064EE38DDB;
	Thu,  9 Nov 2023 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyNKwXmP"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9B38DD7;
	Thu,  9 Nov 2023 21:29:57 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9103C05;
	Thu,  9 Nov 2023 13:29:57 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso1421750b3a.2;
        Thu, 09 Nov 2023 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699565396; x=1700170196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFhJIVYZGPS0s7Wh0Jk+wdSy/r1C+BVbMLSFexUo/0U=;
        b=kyNKwXmPOZrnGImJtCAep/e2QfnvPoH2aq1CWrsdpVZ302WMRyBo3Wo0Hlc+C0WVuT
         vrnMxOZsV6Vw1NCVLtUARBy+4WrbY8jVlqotJ/Gq45Wby8r7VITisyzMUKRoH3ocVg9p
         4AQbj+yXvP1+/RENdU6wLrGUdiCTJ+xzXZUNBVjXW1PxjK+Yw09GlPyJSKud8dxgoMwp
         aKAklj4daCNMfdihuPRVr8qQ5X+NLUNJzUVPY2+ATNpWKO+1KlSSvf6D1P0cVt8EU+XP
         MZdXoi9nAtgHCp1nxoU/ieaxehs7B8gI7vFYxHC8orj/JKdTK1nCFQlNd8PYk3PMwYni
         jTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699565396; x=1700170196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFhJIVYZGPS0s7Wh0Jk+wdSy/r1C+BVbMLSFexUo/0U=;
        b=sMtoDS8WmFxjAPPsFxNGIhJ1hqK2LCWpror8BCOOHVSTiLxLp02/8vJSf+QlLgBM+p
         bRko8a9SLpydEsrVxxirCkKeKYCEgAJcno2c2KJEw3sFAJTE2jvbVdoJg/j9BF91lWn0
         m+1WtIlVLAX/qfRXT2BtT4qqYl4PS5uYD0E3ddSZxvBwxaI+VfCqo1kiPGPk7dKMeTT8
         8POfAtDrYVkyQPHkXHfh7IF4HHvnhGs+ubDyQm0u2t56uD9R0V+5kFF2d1fihxsJ91of
         Tg0ymN1qOWbC7ry/GIDd5QeF6+15ZexHPiIL74GcQsBzt5NeZBftHMvPV9pXxYZxXNsx
         +J7g==
X-Gm-Message-State: AOJu0Yy3978OOgqr5fifFVArlLZJTd75WGye8SJSfHjgpXW9mpszLuH2
	DBQ8r29Eu9J4CiViwJDHGuI=
X-Google-Smtp-Source: AGHT+IGMeKEv6LwZDIgVRdLgaZ/LvlFkDzgmQl6eNvYSzhncmm+BB2Op3oILqIvlweywtvxAFcsqxg==
X-Received: by 2002:a05:6a20:8f13:b0:15e:d84:1c5e with SMTP id b19-20020a056a208f1300b0015e0d841c5emr7397956pzk.38.1699565396450;
        Thu, 09 Nov 2023 13:29:56 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a0007c700b006bdb0f011e2sm11192033pfu.123.2023.11.09.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:29:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 11:29:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1
 hierarchy
Message-ID: <ZU1PUtBr092N2E1r@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-7-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-7-laoar.shao@gmail.com>

On Sun, Oct 29, 2023 at 06:14:33AM +0000, Yafang Shao wrote:
> A new kfunc is added to acquire cgroup1 of a task:
> 
> - bpf_task_get_cgroup1
>   Acquires the associated cgroup of a task whithin a specific cgroup1
>   hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.
> 
> This new kfunc enables the tracing of tasks within a designated
> container or cgroup directory in BPF programs.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

