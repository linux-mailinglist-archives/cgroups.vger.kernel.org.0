Return-Path: <cgroups+bounces-8659-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D054AEE604
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B4B3BF3DC
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 17:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2E2DBF7C;
	Mon, 30 Jun 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/gQjrsk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AFC29116E
	for <cgroups@vger.kernel.org>; Mon, 30 Jun 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751305234; cv=none; b=PC77wGgxZz+FBwSE+2jewXGZcZhOZpZbcWTKXi90EhO9DsiipfP2hY9G37+6v+8ncfXTARLcX9ZmvuWPVO3ts45Vj4PuSRRO8dr6iGvCS0XrV5/ruEKY7nUw6auYykH82OBMavv/S0OeFysC9oCDRnrigN2H7UWE0q/yH1NDbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751305234; c=relaxed/simple;
	bh=sDPU6bO8ExBa+wJj21pGHQYwTA7ckq1nAJsUXRzp8CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXL4A2pijRzz8EBfRlrctsqEXYaSfh6fcU4lRC54/rXcCT592rVyJDFRwufWMuyjxHEpz+aQq1RlPbW4bJj7YhhX/7jDQPeyZbXsuuuWBmc1h8Y6fR1AeBsA6nb7VmTLx1rx6eAwsSqy7TnPkA2lN8WtKkNSYXqouBmhWbz9JJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/gQjrsk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2431494f8f.1
        for <cgroups@vger.kernel.org>; Mon, 30 Jun 2025 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751305231; x=1751910031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDPU6bO8ExBa+wJj21pGHQYwTA7ckq1nAJsUXRzp8CQ=;
        b=O/gQjrsksUpExQ+cerCU3y9k6eE/ioPmjwBuC/+mw7Tfco/kBpdvsQ7/lQqC6tMrER
         oUugz3eCxGBfidetZrJjDNT50W8EuApxSsMkrNUUimvKIm1V/nojlfY5/Qy32e2fzGWa
         R9ccF77P9uu2J7/25w8h++FKbBBSmCCfHy28eEh7rcwCdSli4E2jRSnIpjS0IRMwuP9R
         79dZQh9c+4tJ03ue7RKOno0k/+G4tcUV6PLWGpdhbnYeh0zRkndQ8yDAGB6WY5nF33Xl
         NTdXoTspKgjYKT6liTplFnBHh/qa1ijQarNPG1xAyYc30HEqU/GEpPBpFczv5/HYC16q
         KvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751305231; x=1751910031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDPU6bO8ExBa+wJj21pGHQYwTA7ckq1nAJsUXRzp8CQ=;
        b=R5YyqUVz1M2vaNr9YPTjhnEq8rvC4+RfK9oPt913ujGMYJw22Qb5bJJdDDTT3kLYAX
         CQ81cD2HqM0WHZCAdME1vzLcy3VevKXaNEDKY4OfzMV6dzYv8itVuY+wRzidW9409J/k
         bEWpJiSLCEs2q/ublCQho2d08JefTRymqKIpfzRBN53MKhSz3+NaRhF8IuWPRHFH7xPQ
         mA61jn6d1csE/GTHBrvfiSRHRJd0fXKY/DkhpbOzQhVWRS9MZ0VFxyxB0rY87VwP8K2E
         RgonfXx4AJ3ORvykBVGMBfVesKdaDxuf1TlupJyTZXz8yoc1OQfN/LmQnrm3Rg7ke4KI
         FvKw==
X-Forwarded-Encrypted: i=1; AJvYcCWlRLQqjuHoucSaMy+QHK/GSnoc/CHsnFSqQutxk/wLWGN0Xx41agpnHvub6dKBrOSX2QUTBL06@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8k9c0AJnIOa3QIsvc7vZlV+fTjCJ4NVrFSpiY6uWUfa+ACFIS
	oboxBYB8SGSymTjEn5dOQS2rA4CR9jI3NsoYt98QqfgYIe3OjlWgQkh51+sTH6kY19g=
X-Gm-Gg: ASbGnct4P0ZYiCXUm+JxZkQCW5PLctjkFiOUVz4UhmBlqJNVMsEx8/Z/w8VFtHjNJOI
	Ngrdt4vbAF3MtEXCckypLr6xZOVn55xS23Lnh9k4Sc82/dNndyiRf62t4/al1JYoC7q6HIKCPRi
	iUx44ZGrEpGBbVnMLXXNdMw/wZ30eVREbwrdYrC6Q16GkKcLny9tRo05phv17kxNesc7qp3rs8m
	dWqz8ykkO7UdHKEXZjIQ4EvlkDrRrUgO9672IXjmWI/x1GFS7PYA+YVTc2TQ6BaUA4STc3F2Yd/
	4ofCuYFGL7r74RpCpaOa2+2/stEkS8ezg5bHCUmPuHoqHhPmibqDwzod1itcZ4C9
X-Google-Smtp-Source: AGHT+IH+GjtEXN/h8/C6vsZ4Wo0GrIMYfCWE/katLEA3Cl1hrbNXZ7dRHxUdSMY79vE1MYNL6qKphA==
X-Received: by 2002:a5d:5f92:0:b0:3a5:39d8:57e4 with SMTP id ffacd0b85a97d-3a9002968a3mr12054061f8f.41.1751305231025;
        Mon, 30 Jun 2025 10:40:31 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fb67dsm11205310f8f.35.2025.06.30.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:40:30 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:40:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	kernel-team@android.com, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
Message-ID: <ry6p5w3p4l7pnsovyapu6n2by7f4zl63c7umwut2ngdxinx6fs@yu53tunbkxdi>
References: <20250603224304.3198729-3-ynaffit@google.com>
 <gn6xiuqczaoiepdczg364cj46riiskvqwgvyaawbb3bpaybaw4@5iiohkyscrek>
 <dbx8h601k4ms.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yt7skpektyeugjjr"
Content-Disposition: inline
In-Reply-To: <dbx8h601k4ms.fsf@ynaffit-andsys.c.googlers.com>


--yt7skpektyeugjjr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
MIME-Version: 1.0

On Fri, Jun 27, 2025 at 12:47:23AM -0700, Tiffany Yang <ynaffit@google.com> wrote:
> In our case, the deadline is meant to be relative to the time our task
> spends running; since we don't have a clock for that, we set our timer
> against the system time (CLOCK_MONOTONIC, in this case) as an
> approximation.

Would it be sufficient to measure that deadline against
cpu.stat:usage_usec (CPU time consumed by the cgroup)? Or do I
misunderstand your latter deadline metric?

> Adding it to /proc/<pid>/stat is an option, but because this metric
> isn't very widely used and exactly what it measures is pretty particular
> ("freezer time, but no, cgroup freezer time, but v2 and not v1"), we
> were hesitant to add it there and make this interface even more
> difficult for folks to parse.

Yeah, it'd need strong use case to add it there.

> Thank you for asking this! This is a very helpful question. My answer is
> that other causes of delay may be equally important, but this is another
> place where things get messy because of the spectrum of types of
> "delay". If we break delays into 2 categories, delays that were
> requested (sleep) and delays that were not (SIGSTOP), I can say that we
> are primarily interested in delays that were not requested.

(Note that SIGSTOP may be sent to self or within the group but) mind
that even the category "not requested" is split into two other: resource
contention and freezing management. And the latter should be under
control of the agent that sets the deadlines.

> However, there are many cases that fall somewhere in between, like the
> wakeup latency after a sleep, or that are difficult to account for,
> like blocking on a futex (requested), where the owner might be
> preempted (not requested).

Those are order(s) of magnitude different. I can't imagine that using
freezer for jobs where also wakeup latency matters.


> Ideally, we could abstract this out in a more general way to other
> delays (like SIGSTOP), but the challenge here is that there isn't a
> clear line that separates a problematic delay from an acceptable
> delay. Suggestions for a framework to approach this more generally are
> very welcome.

Well, there are multiple similar metrics: various (cgroup) PSI, (global)
steal time, cpu.stat:throttled_usage and perhaps some more.

> In the meantime, focusing on task frozen/stopped time seems like the
> most reasonable approach. Maybe that would be clear enough to make it
> palatable for proc/<pid>/stat ?

Tejun's suggestion with tracking cgroup's frozen time of whole cgroup
could complement other "debugging" stats provided by cgroups by I tend
to think that it's not good (and certainly not complete) solution to
your problem.

Regards,
Michal

--yt7skpektyeugjjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGLMCgAKCRB+PQLnlNv4
CICTAQCwJTOL9Cw6RFMN4JRHX6xIXQ7ir1qtV/o3cUZo8M749wD/WZxiV6PKbnV/
ZlsyYOCjy/M/7yml9Tbmzhp46hU79QU=
=i0k9
-----END PGP SIGNATURE-----

--yt7skpektyeugjjr--

