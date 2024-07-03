Return-Path: <cgroups+bounces-3524-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D328A92673F
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E485283338
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E036E1849C9;
	Wed,  3 Jul 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjVIJBBm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59205567D;
	Wed,  3 Jul 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028075; cv=none; b=kSD6DLmBB2ePNR6TZmohGHrK8/sZlJLVHlUjRC4xhXSc8DPzc3Xt/+w4qeY+gsnoZ8gDbNwSnoEwZ5CW+i45SAEQ7fi3XbaHVGH/0Sm5CATv6T7TMRNigYfQth+ekCatMLAOXBTycXnP2Hco4B24tNFO/19clJfwBdLpoEw8mug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028075; c=relaxed/simple;
	bh=HBfXZt3Bf8zxygFvg78qE7ukYKUD8Sl6MAHex3YzU3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiZdJKeongX5gP46gOKUO5VjCxKGn9T8XM4Y6jKBSub/gmGGJ9KU/wJFvQYf+hScn8GUwJnq4+pafWmOv20lGH8ETNZY8PouA4S8XvZPp41FFmXsZJp60Bbp7I6/AIlKcjC6fn4VfqdBvS2gBV8Q6voqhuMpD+GbHOQsew+ctG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjVIJBBm; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25d9d15ad5aso2860634fac.0;
        Wed, 03 Jul 2024 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720028073; x=1720632873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFSLghJkWyAsKPrXhIlT2kVU3RtK5nBNiBfKX5CoJ+Q=;
        b=MjVIJBBmMmSmsR9zkDKfuxXDVbiB+HBKVUUPSHjnIDUrgzSeXNhNoDqNVaNOGfKrBs
         dl3QStBd+/Rnast5848bxei9UIYZUoNGTngv81JH2mWJwjJEfmVp8x218Cl/4l1I7IFx
         4Vbd0oCx8w3bSAMmFanBWNONR81FcukzV1XAApCIGg/dlCrhZ4JwugMoL5R0VCHgobEs
         tYqlcYNWQUYsqdwqqaTjsZcKSrA9a3Gef5OLbytbERExlC43Lbbf/0XhzrsHRsShWwUs
         kvjxbAWtn2aiW4zfVYi4ji2ziWEfBMi/YlucAReK8cOyb5qxQm4VMCp2jT3hjHaEARwG
         udsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028073; x=1720632873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFSLghJkWyAsKPrXhIlT2kVU3RtK5nBNiBfKX5CoJ+Q=;
        b=hw00TtXYZsAjp93xxD+vUxnEosOSjvaSG0G7MB7L+9mjx8LYuu6lew/T8KxR1wxKx6
         q/Qs9TnGyfUTgbZUssRKrZ+ZV8pYBIpPkLs6CCyY3HGubJxsLs+5PdD2j9f7QVHNH5uu
         gfkUU3pE+JCVcVsg7niKy068el4HcS3a+2PRbVmfikrV3NFFAoYf4gkOcLdOZ5zw5HjL
         anmknUAxyH00HcByXipoc7PVMC70FkMWmc93dgifHfvF+7tCdPnMvAI98Vj6y1kFq+zK
         P7ZCr/hkajDp1ajyLXzf6fzCOh809wXxhVL/o47I4sGsj4vBI/QzkM2Adw9YSl4QwcFV
         YlkA==
X-Forwarded-Encrypted: i=1; AJvYcCVG4hdBa4EbI6vxmWcG4Plm7irt55z5GnGoujnKAnAt2gTioEyZl39X9+j5Mx8rp2szvZIh9GcsDRO7Kx5hhU803mPwwFtihDlBHmZvI0GkxhMT5LDTJMRHuGiqj45wsaa2EBaHUg==
X-Gm-Message-State: AOJu0YzBQqLoXxxPXrgWabPqgcJTtPf+aFvfi+JwLvDR8vfL/pGL6rrN
	06ySvYLS3iP+IgOnfzaQzt4XEeGco9hLuuhqkbjkucIO1G8OjHnzevHAuw==
X-Google-Smtp-Source: AGHT+IG3KY742s11iWtD+QX4oRlKKP/6ei+voU5mt+2FCxPfMnuoN5inCoJBt+zHp4NlRZbO0WvkVw==
X-Received: by 2002:a05:6871:589f:b0:254:bca4:d9e8 with SMTP id 586e51a60fabf-25db33bd0c9mr10974784fac.18.1720028071247;
        Wed, 03 Jul 2024 10:34:31 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295961fsm10998393b3a.93.2024.07.03.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:34:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 07:34:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Xavier <xavier_qy@163.com>, longman@redhat.com, mkoutny@suse.com,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH-cpuset v9 0/2] Add Union-Find and use it to optimize
 cpuset
Message-ID: <ZoWLpTmZlw9a8gDU@slm.duckdns.org>
References: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
 <20240702105010.253933-1-xavier_qy@163.com>
 <ZoRThI4lcZLxBlwc@slm.duckdns.org>
 <20240702173137.4987350c977529cc554d9632@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702173137.4987350c977529cc554d9632@linux-foundation.org>

Hello,

On Tue, Jul 02, 2024 at 05:31:37PM -0700, Andrew Morton wrote:
> OK by me.  cpuset patches live in the cgroup tree, no?

Yeah, so, if the cpuset conversion part looks okay, it'd make the sense to
route it through the cgroup tree. Otherwise, we can also route the cpuset
conversion through -mm too. Either way sounds fine to me.

Thanks.

-- 
tejun

