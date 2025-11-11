Return-Path: <cgroups+bounces-11827-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C43C4F880
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA203B683D
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7462E03FD;
	Tue, 11 Nov 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g0piEOi7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF952DFF19;
	Tue, 11 Nov 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887807; cv=none; b=dI+ZoBExHkha+qDn9wBfhhoolULEYOqEB+UmzEdgHSVKCiwM0SQi00f2isoSpcY1wye1vUBeFkyVBWCMoaY1KKoC+Wk0vNxnybQQPGEQ9O7KZy82i/lPewfGYg43aNiryAzyXuPkrR13Fpc1HGRo+egqKEX3/kyQCRvBmBwdoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887807; c=relaxed/simple;
	bh=3zgESEYAIvNVUkg5WsXMsMmIkqCNerBYf8EmQWuMLCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VN0RSur7DGOpBQYbDRSd1bqdfYVfVkHZkLqxaoAEU0f7/RVkgHvrUG0XCrehIQcGiD/Z9Ekd/9JW7RlYdd7WSKlqu4kzlWgzTW1elJrsFsG0jxdge9SLUUFWei3PjGDk4Cokg07JhhH9pQvWslOiQqU4VVUd2qZrVdFjRXZqCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g0piEOi7; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762887803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DW8aN6cJL9dQFQJZZx/YDopoyiRzOsZu1J7Nkl1MZyE=;
	b=g0piEOi7PUNvhRsEedKkUKToKKhRiRVhkUdb3LpP8NXbecrf9b3s8VAaPeLvtQGogIZlsr
	hAeUk3T/QXj1j5qRVb71vKrkldRbCPpU2JzwWMajvTO3vnA5hBoeA80IFo29+LjL0ewnzv
	FtZ/b2SlKMv43H3BJwsRfu/Fu645uBU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,  bpf@vger.kernel.org,
  Martin KaFai Lau <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
In-Reply-To: <aRG1AX0tQjAJU6lT@tiehlicka> (Michal Hocko's message of "Mon, 10
	Nov 2025 10:48:49 +0100")
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
	<20251027232206.473085-13-roman.gushchin@linux.dev>
	<aRG1AX0tQjAJU6lT@tiehlicka>
Date: Tue, 11 Nov 2025 11:03:16 -0800
Message-ID: <87bjl8qtmz.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 27-10-25 16:22:06, Roman Gushchin wrote:
>> Add a PSI struct ops test.
>> 
>> The test creates a cgroup with two child sub-cgroups, sets up
>> memory.high for one of those and puts there a memory hungry
>> process (initially frozen).
>> 
>> Then it creates 2 PSI triggers from within a init() BPF callback and
>> attaches them to these cgroups.  Then it deletes the first cgroup,
>> creates another one and runs the memory hungry task. From the cgroup
>> creation callback the test is creating another trigger.
>> 
>> The memory hungry task is creating a high memory pressure in one
>> memory cgroup, which triggers a PSI event. The PSI BPF handler
>> declares a memcg oom in the corresponding cgroup. Finally the checks
>> that both handle_cgroup_free() and handle_psi_event() handlers were
>> executed, the correct process was killed and oom counters were
>> updated.
>
> I might be just dense but what is behind that deleted cgroup
> (deleted_cgroup_id etc) dance?

It was a way to test the handle_cgroup_free() callback, which might
go away in the next version. If it's gonna stay, I'll add more comments
around.

Thanks

