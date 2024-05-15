Return-Path: <cgroups+bounces-2920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7BC8C6B23
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 19:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87291C224DC
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09E538DE9;
	Wed, 15 May 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/+QdZfd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD01802B;
	Wed, 15 May 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792419; cv=none; b=W/SHZRKHbD6tD4wHjZtlYn5IZOb3FqAxaUE7Nulo3u9cvNictylphR59ipFg6Ahv3Qm7aDJmm0tBNXRq4tF69gmOock/+Ft6BV4c8oEJBnXqEMCLgzAC0hjEQU/qnl/tQExMzxNNErBmlct+PgS4Ozu2mtdmJyyBZXiOLZG4wWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792419; c=relaxed/simple;
	bh=l4PH7I6OL5p39oWGVsKZ2XgG4P5yf60Kl+VEfBip2+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/tuaGdOPMc24ffYqGW4gQ4SCcTJt7nGdsTi00WCdFcwUQ6//DFsjrDjuXtmDJM6cthBSVi7FqumXnJNVa3h91lw73uIXvqUzYL3BpRRYroc+EOBXfrTgSm4sqy39AvyZw4EgArHPJvhcbriQlCwI1k9ruyJohlsJZHJc59t144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/+QdZfd; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b2e942171cso1133270eaf.3;
        Wed, 15 May 2024 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792417; x=1716397217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztWuJKUB2kUkxBkt2qGizUFIOwiieGPZAc0z1Q9sNvE=;
        b=I/+QdZfdtm4uX5cy/VuJ1FBa+pl8ze8DQsJM0Yem8vYmFjJ/EECByH5FfIWJ49pp6l
         CH/5W8tLPTtypD8TsbqbQ2QBnKrzH8LVGCZZ7/OWR9SuRBfBSK9X0r5qrcqvjxJxBo7D
         OLmX/9ptIYg+I0TbD2f2Gr/qO1UKJxMXeAohaF7qM47ge4rRxtrehOSApIGV9wXpnY1+
         P5lxXXpRQiPwFp7oOkJWOujHlt21/nFaHG+4Y3rWYHxvfXLUv2NeOG8MJOH3ghjP61It
         sQYOu/V8CFNmzxDJATKOAqesav6kFt9x5ohTCX1kILOSq7bOdlUxkPgutf7WNCQOl5A2
         oKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792417; x=1716397217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztWuJKUB2kUkxBkt2qGizUFIOwiieGPZAc0z1Q9sNvE=;
        b=gNitJJVu2jPJ+MsHYP7IaYJRfyR+hftViVud46hnWs9tBGZcqyU18+3dj2VN3t7XON
         yai0U/fXX+zExprrOhRb6YPHmNmM3ckWapVrB1G7b+1cnET/C/rGPIf3NUTt5BupFBFw
         rajxb3WlDBoIZUHqo7WBmj8n60cgG00elswuozc+64Re8esFJZKtMEHzER/lCsmGXuL1
         DxBpSj9nPvFvFKba7hobnLig0tA9iAfbaTFel8huU30lxbAADJ/QK61TRQmzBvz6HCJq
         c7aF7SQDPRM38x7m5aVjbVsDSeD8vKNeHAGa7YvxzArgloi+0JQXltuD09RYgFHHi7gi
         cmww==
X-Forwarded-Encrypted: i=1; AJvYcCV+7/byx+jr3aM0CUsSzwQT4vnKrPbvrlRuGbOIeDjVSKJT/aFKkhnhTdg15G3hsVEH7dhwwkzBK2qDDyHS+unUio9fDUC5QDQwc85D/X6/AgKoTDl1X84J0d/Zo24rsxSO5keMB/twS/KI5QSH/fNhkmvbo+bcSEyhCruP11kxj0cN
X-Gm-Message-State: AOJu0YxFfJH9MjGeR8kxdOX8o6tBwJOIog/exST7klGS6LHxxuYvgHYM
	odxyshmO5nUh3R1Ax8xIfhd/eYVaXFA2UxsPnSsWpC1yVYcIvdATqQ064A==
X-Google-Smtp-Source: AGHT+IHLXDd5iZw3cSyEW2Xx8gG6pVUp8WIX00xcwNYcmq0TARtdWfJj/qGbWrestPmohe9xpTGejg==
X-Received: by 2002:a05:6358:6214:b0:194:801b:151b with SMTP id e5c5f4694b2df-194801b1919mr484472155d.7.1715792416887;
        Wed, 15 May 2024 10:00:16 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341134705dsm11678185a12.85.2024.05.15.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:00:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 07:00:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: Properly propagate the iostat update up the
 hierarchy
Message-ID: <ZkTqHlkm0G6g_NSk@slm.duckdns.org>
References: <20240515143059.276677-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515143059.276677-1-longman@redhat.com>

On Wed, May 15, 2024 at 10:30:59AM -0400, Waiman Long wrote:
> During a cgroup_rstat_flush() call, the lowest level of nodes are flushed
> first before their parents. Since commit 3b8cc6298724 ("blk-cgroup:
> Optimize blkcg_rstat_flush()"), iostat propagation was still done to
> the parent. Grandparent, however, may not get the iostat update if the
> parent has no blkg_iostat_set queued in its lhead lockless list.
> 
> Fix this iostat propagation problem by queuing the parent's global
> blkg->iostat into one of its percpu lockless lists to make sure that
> the delta will always be propagated up to the grandparent and so on
> toward the root blkcg.
> 
> Note that successive calls to __blkcg_rstat_flush() are serialized by
> the cgroup_rstat_lock. So no special barrier is used in the reading
> and writing of blkg->iostat.lqueued.
> 
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Closes: https://lore.kernel.org/lkml/ZkO6l%2FODzadSgdhC@dschatzberg-fedora-PF3DHTBV/
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

