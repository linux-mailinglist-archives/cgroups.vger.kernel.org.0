Return-Path: <cgroups+bounces-12825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B5CEA8AA
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 20:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD573021FBE
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D82D94AF;
	Tue, 30 Dec 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZA8itra1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F94242D89;
	Tue, 30 Dec 2025 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767123319; cv=none; b=r7pvII1y0Yc4pRxiqPCArpjybYno2i0xJKcvFoGT8YbN6Ml0m1GqcbhBAjJ2R4SNAAkNoH6E0EvdS+8gcVCOOdbDAr17+oNaoPIuKsBzmh6WpAIMFqY0o2MfZhM+wvNR365k7RIXmQzrVR930a7VF/uAJzPzwpAHOIAj1FGghYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767123319; c=relaxed/simple;
	bh=8JvVW0h8pOXsIoPb61B6PldoNUcuCfOrCTs1kogPt7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvhJmGJ0FXpj7tudnXhzOKE6lLU44ZO9sdXlXxI/WEasxLn+RQz6mCsIarFU6cZ58fFZwbqXwWId6piP24psAUKzlgzHAztHmd0QSvWn4kkk012elFB5GxpVXMSeiThNjuoPXYMeyZUIq7tA8xW4I5Ldym/VrK6edHuOTuxl7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZA8itra1; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767123314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETalyka5/PpC6aEbKJT5o3+SH5gyurFKwJhvvqygqBA=;
	b=ZA8itra16aVqzZr+0m4LBwXo81olvMu2gDSc4UzXRKUsmiipcN5ar7YskQJ/4zTdozZ1d6
	Yc4ENiQ/anPmCyWWklSb6ca213++F6Bh136EjjY6PeNse/ltKLUv+BPwnxmYIRFMQpmtmu
	DxMgU17Wtwbhd55p8GlUf6mHci+7ltE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,  Qi Zheng <qi.zheng@linux.dev>,
  hannes@cmpxchg.org,  hughd@google.com,  mhocko@suse.com,
  muchun.song@linux.dev,  david@kernel.org,  lorenzo.stoakes@oracle.com,
  harry.yoo@oracle.com,  imran.f.khan@oracle.com,
  kamalesh.babulal@oracle.com,  axelrasmussen@google.com,
  yuanchu@google.com,  weixugc@google.com,  chenridong@huaweicloud.com,
  mkoutny@suse.com,  akpm@linux-foundation.org,
  hamzamahfooz@linux.microsoft.com,  apais@linux.microsoft.com,
  lance.yang@linux.dev,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  cgroups@vger.kernel.org,  Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
In-Reply-To: <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com> (Zi Yan's
	message of "Tue, 30 Dec 2025 11:46:02 -0500")
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
	<7ia4ldikrbsj.fsf@castle.c.googlers.com>
	<1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev>
	<87tsx861o5.fsf@linux.dev>
	<c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
	<krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
	<03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
Date: Tue, 30 Dec 2025 19:34:42 +0000
Message-ID: <7ia44ip7227h.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Zi Yan <ziy@nvidia.com> writes:

> On 29 Dec 2025, at 23:48, Shakeel Butt wrote:
>
>> On Tue, Dec 30, 2025 at 12:25:31PM +0800, Qi Zheng wrote:
>>>
>>>
>> [...]
>>>>>
>>>>> Thank you for running the AI review for this patchset, but please do =
not
>>>>> directly send the raw data from the AI review to the community, as th=
is
>>>>> is no different from automated review by a robot.
>>>>
>>>> Hi Qi,
>>>>
>>>> I don't know why you're so negative towards it. It's been great at
>>>
>>> No, I don't object to having a dedicated robot to do this.
>>>
>>>> finding pretty tricky bugs often missed by human reviewers. In no way
>>>> it's a replacement for human reviews, but if a robot can find real
>>>> issues and make the kernel more reliable and safe, I'm in.
>>>
>>> I just think you should do a preliminary review of the AI =E2=80=8B=E2=
=80=8Breview results
>>> instead of sending them out directly. Otherwise, if everyone does this,
>>> the community will be full of bots.
>>>
>>> No?

The problem is that it works only when AI is obviously wrong,
which is not a large percentage of cases with latest models.
In my practice with Gemini 3 and Chris Mason's prompts, it almost
never dead wrong: it's either a real issue or some gray zone.
And you really often need a deep expertise and a significant amount
of time to decide if it's real or not, so it's not like you can
assign a single person who can review all ai reviews.

>>>
>>
>> We don't want too many bots but we definitely want at least one AI
>> review bot. Now we have precedence of BPF and networking subsystem and
>> the results I have seen are really good. I think the MM community needs
>> to come together and decide on the formalities of AI review process and
>> I see Roman is doing some early experimentation and result looks great.
>
> Do you mind explaining why the result looks great? Does it mean you agree
> the regressions pointed out by the AI review?
>
> If we want to do AI reviews, the process should be improved instead of
> just pasting the output from AI. In the initial stage, I think some human
> intervention is needed, at least adding some comment on AI reviews would
> be helpful. Otherwise, it looks like you agree completely with AI reviews.
> In addition, =E2=80=9C50% of the reported issues are real=E2=80=9D, is th=
e AI tossing
> a coin when reporting issues?

I said at least 50% in my experience. If there is a 50% chance that
someone is pointing at a real issue in my code, I'd rather look into it
and fix or explain why it's not an issue. Btw, this is exactly how I
learned about this stuff - sent some bpf patches (bpf oom) and got
excited about a number of real issues discovered by ai review.

I agree though that we should not pollute email threads with a number of
AI-generated reports with a similar context.

> When I am looking into the prompt part, I have the following questions:
>
> 1. What is =E2=80=9CPrompts SHA: 192922ae6bf4 ("bpf.md: adjust the docume=
ntation
> about bpf kfunc parameter validation=E2=80=9D)=E2=80=9D? I got the actual=
 prompts
> from irc: https://github.com/masoncl/review-prompts/tree/main, but it
> should be provided along with the review for others to reproduce.

It's a significant amount of text, way too much to directly include into
emails. SHA from the prompts git should be enough, no?

> 2. Looking at the mm prompt: https://github.com/masoncl/review-prompts/bl=
ob/main/mm.md, are you sure the patterns are all right?
> 	a. Page/Folio States, Large folios require per-page state tracking for
> 		Reference counts. I thought we want to get rid of per page refcount.
>     b. Migration Invariants, NUMA balancing expects valid PTE combination=
s.
> 		PROTNONE PTEs are hardware invalid to trigger fault.
> 	c. TLB flushes required after PTE modifications. How about spurious fault
> 		handling?
>
> 3. For a cgroup patchset, I was expecting some cgroup specific prompt rul=
es,
> 	but could not find any. What am I missing?

MM and cgroups-specific prompts are definitely in a very early stage.
But to develop/improve them we need data.

Thanks!

