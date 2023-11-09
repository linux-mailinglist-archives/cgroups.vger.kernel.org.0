Return-Path: <cgroups+bounces-295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4A47E739F
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30605B20E93
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC638DDB;
	Thu,  9 Nov 2023 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnr2FC4S"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B12138DD9;
	Thu,  9 Nov 2023 21:32:42 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61AD3C30;
	Thu,  9 Nov 2023 13:32:41 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-282fcf7eef9so614044a91.1;
        Thu, 09 Nov 2023 13:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699565561; x=1700170361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlzmiwjxA1+oHu6aUOto49yd5dHl5oIrt+Vc7w10TFU=;
        b=Hnr2FC4SbM37sU/23ykc62DceEzxnMP8dl8cWUNSKKXTiiq+xLZXwwima8lDdfhWu3
         RAmPm5+maqR/+XRwfGD8UhkcQsJ3v2cAn7zVkioiWBUp1q6ZjdaZCQP4DPN8yCnIy7K5
         h5lqVPHakRDMZW0RHjc3BkOTtDalfDOcpHr0Ag1lRR4dDDGp8g1GGmIRHeuOBsxu14qW
         Jw8QebSQNe+3DhTJJLX2yJJx+pTne8uQYPn2lKH0UFeCs0yB9VxdbWe0msn4V5kJdSND
         SmC/djNnwzjYKiV4JzpQnA4osP34YW4r/rMGvxd3m2vNv0JbOMyaTG8ekAwmq0Sn8v5V
         PNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699565561; x=1700170361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlzmiwjxA1+oHu6aUOto49yd5dHl5oIrt+Vc7w10TFU=;
        b=TzmLE/gsGGCk58fctItzejaNlp0U2ASYC7+/m0gBAvdM06ZRdgFY1d4uv3yfGKVM52
         iL/8PClkzVyXzTtZFlCW+23mzeCNXYvpQ0c17lj51d24MIjt4bDoD24Ef0o/AIqplM8u
         F8AI1TjSzejy1ySF4cGjegxCF3jocES8rep8DmWlFNuZ9H0tIPNxamnebLwmIbnTAmE+
         Yy1xofBG4p3VFglMPup+pPnkl9pAD0TXDeEujzYcYZJSjPNFh1wXVn8xGMUQoOlW7yuB
         ghTqsY4ua/b20yizd5RZcKezFlG6BnOCeVgJpEAxQN4CkLp+q7thFtIs5RhEdsJDaSpC
         rTKQ==
X-Gm-Message-State: AOJu0YwcVuuCt5qECjcma1dFOK4otiIpFRkrE45QSnYziAW8wZhjda7J
	FhcPDSXWy3Ni/eUz21L4XZE=
X-Google-Smtp-Source: AGHT+IEA7NDsyQnIGdDX5HsWywJwpikl9gfSy0x3FLEjgKLrhhRkfzgr1o0VG0LUjB8cLCVVqpxfxw==
X-Received: by 2002:a17:90b:1e02:b0:280:a6a6:9b1b with SMTP id pg2-20020a17090b1e0200b00280a6a69b1bmr3032582pjb.19.1699565561141;
        Thu, 09 Nov 2023 13:32:41 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id mv18-20020a17090b199200b0028012be0764sm261544pjb.20.2023.11.09.13.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:32:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 11:32:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 10/11] selftests/bpf: Add a new cgroup helper
 get_cgroup_hierarchy_id()
Message-ID: <ZU1P9_QU4j-9B_U8@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-11-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-11-laoar.shao@gmail.com>

Hello,

On Sun, Oct 29, 2023 at 06:14:37AM +0000, Yafang Shao wrote:
> +int get_cgroup1_hierarchy_id(const char *cgrp_name)

Maybe use subsys_name or controller? cgroup name usually means the cgroup
directory name.

Thanks.

-- 
tejun

