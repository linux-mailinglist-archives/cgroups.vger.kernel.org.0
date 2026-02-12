Return-Path: <cgroups+bounces-13894-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNgZBp6wjWmz5wAAu9opvQ
	(envelope-from <cgroups+bounces-13894-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 11:51:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6F12CB4B
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 11:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B38DC300FEDF
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937730BF6B;
	Thu, 12 Feb 2026 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YfI9AFzt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4B3016E9
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893456; cv=none; b=JuRE7BMrZT0Vwv18bKb4fqd5+s/dNemdcjdXMWSTLW1gWCPpbdFR47gHQxZH2K7vUlMQodfY3h3/pMZYhq+yQPUlPH1eokzf3XETsiH6fGMLZ0u54EjPAhjWfDbA76xtyBmx1cQOO/XZFRSwp01JjJjDCwL+NMuNAYJmFsF5qTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893456; c=relaxed/simple;
	bh=RLuc4X4jAHTUGvP3HxaP9tCohxJ0RQD4k5ssP2M8cfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWbCrHj208uw8mRxw/+nKowPZ0eIZopJxGrIy7VgSMv3Rafrd1HPFsA+5TbMRdcofOu/ogyD7MylDbjNPHCMAuAOMcXi9FkmQBhC9sW6ms1qDDFIVGGE5pcgiabRz9lPdoQbbAP6PAWJt75tbrw0bhqz52ZahSMAfvTK8EZmX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YfI9AFzt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so80391805e9.3
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770893452; x=1771498252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RLuc4X4jAHTUGvP3HxaP9tCohxJ0RQD4k5ssP2M8cfw=;
        b=YfI9AFztX66k9mhOtc1XbRZzh7C9LBUqhzazs+ok/HWpxdXeMUffvO7T8O6cjm6JmM
         bJhQWVw8J0qk/lZnCWh7fuucfvan2W3Z9kHFt5czWxnNmt+0sZX8gFu5Sk+sn5i0lEvP
         Vbx/OGdd187H1sTKiNFDxXMMhMC8AIktEuQPlUNaZr0za1V2ITX9AkODbco0y09dJZ3i
         6ycPDCX1bLlwBnZnayVtemvOsxWKZJYcjRSSBeI7Ia1Q0dYRiRBH1CIPwSCQgGwD1Y6+
         lmLXQdS1VQssDxWGitsV5qedrrqauNV6hVN+szzdEzKKvF415LMhdh7krmhmZliaADaY
         8QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770893452; x=1771498252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLuc4X4jAHTUGvP3HxaP9tCohxJ0RQD4k5ssP2M8cfw=;
        b=a1OblZX4KZWNwosx9KGKgjrHq/2chxSL317eTfSLNzW4posSYRUF4jqPulT0pRDuHE
         pyDdHLMSAHQQsCQNifc9Be3yujQd7gRFTBJm9k9ilKcLS/p9+2x0NsnBMFgR6WtrYM5n
         1jPYAW/rUExxBdgR/EYIm83exYPQdawcn4wbGiQigrI/LC0VMVT+lbiGwQuRQo2PARul
         AHod1QbZ4Ed7o9ZqS14rd2K8DRIiSL9+ZQuXyZr/tB/Y5eVqMGfVU7BYb5badME4jEGe
         yUNgAxvDTIVe0SdliZTtOWdFrzp0ryFjG324vMh5gtEbdrMnvUzKJQhira2InmCo3X/G
         ETeA==
X-Forwarded-Encrypted: i=1; AJvYcCW6F5Ov4P0M7/5s/kfvrvl74rHhZju4/zdgCgoi+3GvNDF8UJdpPHaGC046T/Q+f5GSdoB5OY9C@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSwxGs9z6ipkK5/+Rhpy+LtzLsZTuTAS/zJwmf/0dtY/nFYH3
	gNV7b6UGjP8J0HAmunT+SVpHwI6CM9qxLWNigRqc3tzhUa3vIUKQO3P+twzd5fRWWAk=
X-Gm-Gg: AZuq6aIE/vYUaQIlk0FAbKO21LfOQl7Gdr4E0GjZ3gzdgIMJNYDV3MwBzTDO2UpVMpN
	S5+dN79z8I1QOqqVtk87g2wh4NwB/eX9YKLhAYcWBiPoyiSlpyWPWWD0tFLRbQc9xK+l2ubCOw5
	5HnWJTGin676rILKainSd+sIkCMs8X7nEr+9/gBiM1o1+EJz6BgkqGbMNvkRvV+W5gMyCNP7+m1
	UGjG0/vDB+6cGZrk7tQ3eQYdxjm+42M1zBYrWnSsAmhYTZMuXOH9Ue9ewyGiHF68AyQcC+A8mXp
	aEUQNpxySdiZvS7tr7ywNi9eggbxzctTVyqXFuCuqCWb1hmMUja8scIPcL28J6bNloCv8HhmE0X
	x6YpjJhbk9JOzaYHOTITPGKGv761kPSoG7NWaPyXug4UPtZTVhmL7ulvKmy7YI7ZZ6NzQ55Wvwb
	IcPDHB63bpIAN/JSxLqvnsH8yUmUV7sI6GVIsCoge27F4=
X-Received: by 2002:a05:600c:4f86:b0:483:4807:20fb with SMTP id 5b1f17b1804b1-483657166c8mr35745415e9.25.1770893451705;
        Thu, 12 Feb 2026 02:50:51 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a62baa9sm42074575e9.4.2026.02.12.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:50:51 -0800 (PST)
Date: Thu, 12 Feb 2026 11:50:49 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: zhaoqingye <zhaoqingye@honor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: fix race between task migration and iteration
Message-ID: <odm7lzxcekzrfqcb6lzh7uof4nnyc23qzd5ltkbo56ajrw53pr@2k7boeaofuqh>
References: <8092ea7ae48d4a988fdcb7390e1be0b1@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8092ea7ae48d4a988fdcb7390e1be0b1@honor.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13894-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AA6F12CB4B
X-Rspamd-Action: no action

Hi Qingye.

On Wed, Feb 11, 2026 at 09:24:04AM +0000, zhaoqingye <zhaoqingye@honor.com> wrote:
...
> Under this setup, cgroup.procs can intermittently show only PID 101
> while skipping PID 103. Once the migration completes, reading the
> file again shows all tasks as expected.

Yup, such a skip is buggy -- at places when task is removed from
task->cg_list's list, the iterators should be skipped.


> Note that this change does not allow removing the existing
> css_set_skip_task_iters() call in css_set_move_task().

Sure, css_set_move_task() isn't called together with
cgroup_migrate_add_task() under one css_set_lock.


> The race window between migration and iteration is very small, and
> css_task_iter is not on a hot path. In the worst case, when an
> iterator is positioned on the first thread of the migrating process,
> cgroup_migrate_add_task() may have to skip multiple tasks via
> css_set_skip_task_iters().

Only when it->task_pos == &task->cg_list (in css_task_iter_skip()).

> However, this only happens when migration and iteration actually race,
> so the performance impact is negligible compared to the correctness
> fix provided here.

Of course, correctness > performance in these discrete cases.

This is a good catch, well described and correction is OK.

Reviewed-by: Michal Koutný <mkoutny@suse.com>

