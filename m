Return-Path: <cgroups+bounces-8877-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE71DB0E694
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 00:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148D01C87908
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1528727A;
	Tue, 22 Jul 2025 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJu9Riqt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0E2877CC
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224074; cv=none; b=IqtNMmQe6ONlEjwhTDTCqgMMwu23FWpFtWqVyHF28AhqQEaJvHVSlMROtcZBHkoi1W7z2OlYfpTbZ++gr/p14nssrtI+eHtHqMQ0m5Vc3JEnnH9tR90kYOqWNVeblY8qr/oySvl2fsC4tt01ObNO1hBcT1zPz60UpxWIP9rl2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224074; c=relaxed/simple;
	bh=RIVO37juCsCqXBzxtTjGZr09W7FZSUQUcewbbNK0LR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NgohcJStkVLmfCHsrMz46sfWoEFCuBc2F15RMU0vKbZ9F2fKHJgVxXwoRoUDc+A77PM0WOPA2JoIeBu469kcDTSTFMHmu3ls4OAgEVdlU7Lshe/Ga1aojASBkfKtaWFKp7eX2mvaOWOd6/I4FiX3LpCICWdX9x/JZmpTJFs/Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cJu9Riqt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so6036410a91.3
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753224072; x=1753828872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOYa7ZEGNBK60fTKVSOtfx+dioBHWECsFxuIzKb+U7o=;
        b=cJu9RiqtZLXnZa1yPlljl+GNIs797jBnDS69KJ3Mc66ZgfictHywvc6e6vdEfbiNCe
         wB/Or2tCMONKmt3GcunU0pRyrR58mDasKeCf1XD1NBi6UFZ8XbDaIxxPRfCt+ATEVrn6
         UQe8OENDogJ0o5/hYy3TxHEq2f6gtfqpOb71JXQ+Yuj9i2JkGtAsdwzmgRUHKUMJHzM4
         Uzs8UE5oO5+EtUJYwZP6oj7eZFKJg06THxS12YajvCdiriY9tGNG3foTn4KOJiChjrQM
         Igjc8jCMPipuHOe779tlDVEqZVSiO+oAO/CVsDT6sKtfanHh2kaJqiviH7ykLyhIIRbX
         MOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224072; x=1753828872;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOYa7ZEGNBK60fTKVSOtfx+dioBHWECsFxuIzKb+U7o=;
        b=iWZb17oISS/tIm5/HM5Lk56Jw46e8AIkfN7TLi5NSjo2PW7ce47KUwZDqEZyY1hlS6
         zskbviZ19btP2U//7uwTcaZNTM2gqI1BFgqCeP35QvNwJlSCtd8I664osLTqRQTqmMy9
         F+3M2uSP/Ph2at4qGulOpcoNWp5bcfK0Iyh4hkT62wS88g+encr2oPXRDXkBGPdyD2k+
         FnMA45k5cIWrguVJpBMNwx44d6KTz+Ls0XQ5DOuNlPL/QXAAosoe5EvYD0mnYaKpymkS
         RKYpNK/D6y3nFjrEy7WrnPnQFlI4gypWgo6OqBVV9z3n46DUAUrDxjT5uqfSokfXJ+Gm
         MHeg==
X-Forwarded-Encrypted: i=1; AJvYcCXyK2gWnfHLApoo5QVFBJwYpdffJaRJUa8Oe+HjR43SpsRoQRbTTgfZXj7zI2liJpqm+boaAFqF@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGxEfQJP1x069N7sPGR4LTUUts5pL5JIcc7j7HtlKbwESpyGv
	ShFgmvtdX7XKeX2kvcMtHmx90ZdNBDPOVwmQhZ3VudktjGmD+NMDNw6IrerUuTSzoF9RzN93lJn
	gFdLoUJESnw==
X-Google-Smtp-Source: AGHT+IEQDJG0XdYJdm4y/wzvyxG233Rn2TkKUiTzy/vJJmjMYQfTNdCOJXvVMg3gnXeY82hjHaO1NgRYqbs+
X-Received: from pji6.prod.google.com ([2002:a17:90b:3fc6:b0:313:2213:1f54])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8c:b0:313:283e:e881
 with SMTP id 98e67ed59e1d1-31e506ef4f7mr1324033a91.11.1753224072599; Tue, 22
 Jul 2025 15:41:12 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:41:11 -0700
In-Reply-To: <aHktgqO3BUg8exXH@slm.duckdns.org> (Tejun Heo's message of "Thu,
 17 Jul 2025 07:06:10 -1000")
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714050008.2167786-2-ynaffit@google.com> <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <6c9278b7-4eb4-4b47-b61a-a5bcc7e558b0@huaweicloud.com> <aHktgqO3BUg8exXH@slm.duckdns.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8bjpbalx4.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, 
	"Michal =?utf-8?Q?Koutn?= =?utf-8?Q?=C3=BD?=" <mkoutny@suse.com>, linux-kernel@vger.kernel.org, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Tejun Heo <tj@kernel.org> writes:

> On Thu, Jul 17, 2025 at 09:52:38PM +0800, Chen Ridong wrote:
>> > With the given implementation (and use scenario), this'd better exposed
>> > in
>> >   cgroup.freeze.stat.local
>> >

>> Would it be possible to add this field to either cgroup.event or  
>> cgroup.stat?
>> Since the frozen status is already tracked in cgroup.event, this  
>> placement would maintain better
>> cohesion with existing metrics.

>> This is just a suggestion.

> Yeah, given that the freezer is an integral part of cgroup core, using
> cgroup.stat[.local] probably makes more sense.

> Thanks.

One of the reasons I avoided cgroup.stat was because I interpreted its
purpose to be for exposing cgroup metadata (i.e., descendants and
descendants per subsystem), and I didn't think this value fit in neatly.

It doesn't seem like there currently exists a cgroup.stat.local, but if
that is the preferred location for this accounting, I could create one
and print it there!

-- 
Tiffany Y. Yang

