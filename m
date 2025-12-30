Return-Path: <cgroups+bounces-12827-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FBCCEAA26
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 21:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E8E4300F1BB
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 20:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7C2F8BD3;
	Tue, 30 Dec 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wub7OS+L"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049525C80D
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767127693; cv=none; b=T39i6CJTwHwqoZMDLo1VFxse2ZTkYte9kZkgMTj6CkBaSgacQoZ02xtT304MP5ZBnviaT3a0JFQNP3qfHiX5bOP97XAyjPzgTE4+BVFZ5cvZWIfbqE7bmYCa8VnBemHZHAg+1G4bbeAaoonUVOLPZReMviUv/3JseZbn7Lwnxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767127693; c=relaxed/simple;
	bh=ZTv5arboeU7eXOlGtoXQP+yYHqCUQ5mZ/wIuPkmcIeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fRoLL/iBDnWS9JM5s5LxiY59otHTABvvVuBs3HwKBJpfJCilf8XanRxf6lm53VM1tVKTXh1OUXzi9T9VF7XfjTUF00HFXrztG+VM8JejKVOgrwNRH3sPuIDDAIwo1UxB34xBXVENAKY4GnP9KvH/cuHRheyR6eaT6SSvS3Eu5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wub7OS+L; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767127689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVuULU9DWzbX35aYTs+GdWerbt0qAG31AAAaM0plU/A=;
	b=Wub7OS+L16NbJTJN4pl2A/cialO1q+2ltjN+k35LpGDOQBzBCQXojN0OAFrER0w8ETJ7lW
	1FCtFaQlRsMZzpL0etDfrf+cr+AGLIeSwHdeihmiQkt0JaZiGfAfGZB1fhI+feDT7CepUs
	3HJ/XszdHWrhdNwDQRkaEX46ErWO+cw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>,  hannes@cmpxchg.org,  hughd@google.com,
  mhocko@suse.com,  muchun.song@linux.dev,  david@kernel.org,
  lorenzo.stoakes@oracle.com,  ziy@nvidia.com,  harry.yoo@oracle.com,
  imran.f.khan@oracle.com,  kamalesh.babulal@oracle.com,
  axelrasmussen@google.com,  yuanchu@google.com,  weixugc@google.com,
  chenridong@huaweicloud.com,  mkoutny@suse.com,
  akpm@linux-foundation.org,  hamzamahfooz@linux.microsoft.com,
  apais@linux.microsoft.com,  lance.yang@linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,  Qi Zheng
 <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
In-Reply-To: <6o2gnpjd7z7hxl2lu2lyevawtkcas6xar6z4zip4zc3unq27cf@k4bhpnfclnkj>
	(Shakeel Butt's message of "Tue, 30 Dec 2025 10:36:52 -0800")
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
	<7ia4ldikrbsj.fsf@castle.c.googlers.com>
	<423puqc6tesx7y6l4oqmslbby2rfjenfnw5pn5mgi63aq74jwj@jwgorel2uj3m>
	<87ecoc7gnp.fsf@linux.dev>
	<6o2gnpjd7z7hxl2lu2lyevawtkcas6xar6z4zip4zc3unq27cf@k4bhpnfclnkj>
Date: Tue, 30 Dec 2025 20:47:58 +0000
Message-ID: <7ia4wm23y9vl.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Mon, Dec 29, 2025 at 08:11:22PM -0800, Roman Gushchin wrote:
>> Shakeel Butt <shakeel.butt@linux.dev> writes:
>> 
>> > On Tue, Dec 30, 2025 at 01:36:12AM +0000, Roman Gushchin wrote:
>> >> Qi Zheng <qi.zheng@linux.dev> writes:
>> >> 
>> >> Hey!
>> >> 
>> >> I ran this patchset through AI review and it found few regression (which
>> >> can of course be false positives). When you'll have time, can you,
>> >> please, take a look and comment on which are real and which are not?
>> >> 
>> >> Thank you!
>> >
>> > Hi Roman, this is really good. I assume this is Gemini model. I see BPF
>> > and networking folks have automated the AI review process which is
>> > really good. I think MM should also adopt that model. Are you looking
>> > into automating MM review bot?
>> 
>> Yes, absolutely. We're working on it, hopefully in January/February we
>> can have something reasonably solid.
>
> Can you share a bit more about the plan? Are you working more on the
> infra side of things or also iterating on the prompts? (I assume you are
> using Chris Mason's review prompts)

Mostly on the infra side. I want to look closer into mm and cgroups
patches, but I need a bit more data and infra to do this.

As of now we're building some basic infra to run it on scale.

> On the infra side, one thing I would love to have is to get early
> feedback/review on my patches before posting on the list. Will it be
> possible to support such a scenario?

Absolutely.
You can do it already using a local setup, assuming you have an access
to some decent LLM. In my experience, a standard entry-level pro
subscription which is like $20/month these days is good enough to review
a number of patchsets per day. This works well for reviewing personal
patches and/or some targeted upstream reviews (like this one), but for
covering entire subsystems we need more infra and more token budgets
(and this is what we're building).

Btw, I mastered a pre-configured environment which saves time on setting
things up: https://github.com/rgushchin/kengp .
I've been testing it with Gemini CLI, but it should work with other
similar tools with some minimal changes (and I'd love to accept patches
adding this support).

Actually I think there will be several rounds of ai-reviews:
1) Developers can review their patches while working on the code and
before sending anything upstream
2) AI bots can send feedback to proposed patchset, as it works for bpf
currently
3) Maintainers and/or ci systems will run ai reviews to ensure the
quality of changes (e.g. eventually we can re-review mm-next nightly
to make sure it's not creating new regressions with other changes in
linux-next).

> On the prompt side, what kind of experiments are you doing to reduce the
> false positives? I wonder if we can comeup with some recommendations
> which help maintainers to describe relevant prompts for their sub-area
> and be helpful for AI reviews.

I like Chris's approach here: let's look into specific examples of
false positives and missed bugs and tailor our prompt systems to handle
these cases correctly. The smarter LLMs are, the fewer tricks we really
need, so it's better to keep prompts minimal. We don't really need to
write AI-specific long texts about subsystems, but sometimes codify some
non-obvious design principles and limitations.

> On the automation side, I assume we will start with some manual process.
> I definitely see back-and-forth to improve prompts for MM and someone
> needs to manually review the results generated by AI and may have to
> update prompts for better results. Also we can start with opt-in
> approach i.e. someone adds a tag to the subject for AI to review the
> series.

Yeah, there are some things to figure out on how to make sure we're not
creating a lot of noise and not repeating the same feedback if it's not
useful.

Thanks!

