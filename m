Return-Path: <cgroups+bounces-3571-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05AE92A922
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E9D1F21DB4
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BF1482E6;
	Mon,  8 Jul 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCEM8HEd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646B17C9E;
	Mon,  8 Jul 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464321; cv=none; b=T51zzVF3Zyer6tn9pwxiI1t33CqrOtfoWWXTFh8hrV0aFyurhU+zuNNR4F1dcT4yVmUr5L7ED32exc5T8tyIuA4Vj1FPznpz66BEl2B4BrOVLJp7UKvn6AJAzBUugBemUhBLQOynEH1Q40YQsUjMSzt6KKaLVxoti7VNtBfZC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464321; c=relaxed/simple;
	bh=x+md8Yw2vlsX1Vo5jhFawgklg5cgaDj76s25DaKsTuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0fGe2MAo3WC+rHyeh4QEXvptMYFu5V3pbfr4XrQ9EKtFsecH75w5iVfEqz7e/lNGYrWuInGusrGK0E7Vq3RgyhSmn/VaUSf7Ox8FJSTdH6twH3GxPy9XS4434Kq/0HMVTH3xGBekcYrt2sBrKfJcI77PD5KxY2CEtqtVZsAsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCEM8HEd; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c9df3eb0edso1559576a91.3;
        Mon, 08 Jul 2024 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720464319; x=1721069119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7TXhObjjg10CfoE/exetflVyceR3Yc7EDIa0HGfVmw=;
        b=UCEM8HEdPBFx8Q5xsqK/g8FKKKecjMH4F5HhUcDXePz/yXlgaueH1flB3P+hGHMPZP
         4uO0xqwzZVdjgom4sj7Vx5B8hUD1LdDvW5w8VKsZbp2C4z6qhYvodNqMSEsmg6QbpX0I
         v0O8soFYcpMRoKXcwHjvvEhOLvDRXVFp8UOM+SpK0xo3GeCqYJh+W4w+4Vl9SDNDIcP+
         bkOdt9uKCZo1uW7bbqbHWAnjJGAGn/DxhMtJrwdyQ8Hag69NCtdlqa3r4QneVqgz3zmA
         rfknvEsP/y48by+xjcQ0HHPxje5KfVLnBhiiWEvGfRwLBKYblzeDzeNySJJJhagUyA58
         fcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464319; x=1721069119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7TXhObjjg10CfoE/exetflVyceR3Yc7EDIa0HGfVmw=;
        b=Xeipmx+lAMci+PU3b/FkhrPxgvmyk4QPdMXAdHt0iscuejLkGusjv0p2XrPNQEnBcL
         XYVbv6dBy3eur0TM8UUajp5/TaopLs8ihXzVUWuj8qr1JoF/aRsH/On/0gdv+JEOODH/
         yd/kQtTTkVk7gIWb2frOQdDFY/rnvkpu5/AdQBCTcWT86v9SY32XDhO/2wqtEFZhnSHm
         xSFkIRpSvfQarMjkMCltQgaCnN84mVNQ1sQYD7R+SR1NOdYEZVqtjlg6GCJTzWU0KXbd
         yoA9SAYBjFkI0B8aD5X97qMDNryNND3WPwKgmxUAsNgrnxy+4sfRhCMK5mkGCCLxDcYn
         Rukw==
X-Forwarded-Encrypted: i=1; AJvYcCXwVK9fYxU7Pyo2qvhHVQ7ZUdKlk3fuQbrh8LebKnAGK/YD8m03JGQEn4n3MBaFDNpOXALBpadmftBRzwPsYjMdRcKCBcGA/RPa/ALudipGM7hvrBm/Hw9a2b+1g5+x3hC7bvb4ag==
X-Gm-Message-State: AOJu0YzY7npsb1cj/V3wLVR4ojit3Zbs+BXWkVC2R+asQ8haw5kd+/sB
	fbN4hzhSVF5IwE/Rar/dJDKKPIBu9GYOG7iE5+2NZPWXMYWJFRLF
X-Google-Smtp-Source: AGHT+IFVh9il2ma4+p1y4h18bpW6blOTWcBiQJgR4kCqbGo/4tYu2OhH+kzL5lAsaEDZZR9TkOARhg==
X-Received: by 2002:a17:90a:e610:b0:2c9:8d45:7bdd with SMTP id 98e67ed59e1d1-2ca35be7c96mr463994a91.10.1720464318934;
        Mon, 08 Jul 2024 11:45:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a97c196sm8568745a91.26.2024.07.08.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:45:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 08:45:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH-cgroup 1/2] cgroup: Show # of subsystem CSSes in
 /proc/cgroups
Message-ID: <Zowzvf2NEOzgXYr3@slm.duckdns.org>
References: <20240706005622.2003606-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706005622.2003606-1-longman@redhat.com>

Hello, Waiman.

On Fri, Jul 05, 2024 at 08:56:21PM -0400, Waiman Long wrote:
> The /proc/cgroups file shows the number of cgroups for each of the
> subsystems.  With cgroup v1, the number of CSSes is the same as the
> number of cgroups. That is not the case anymore with cgroup v2. The
> /proc/cgroups file cannot show the actual number of CSSes for the
> subsystems that are bound to cgroup v2.
> 
> So if a v2 cgroup subsystem is leaking cgroups (typically memory
> cgroup), we can't tell by looking at /proc/cgroups which cgroup
> subsystems may be responsible.  This patch adds a css counter in the
> cgroup_subsys structure to keep track of the number of CSSes for each
> of the cgroup subsystems.

The count sounds useful to me but can we add it in cgroup.stats instead?

Thanks.

-- 
tejun

