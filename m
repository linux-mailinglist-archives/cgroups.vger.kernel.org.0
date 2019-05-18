Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C545E22126
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2019 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfERBd4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 21:33:56 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:35788 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfERBd4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 21:33:56 -0400
Received: by mail-qk1-f182.google.com with SMTP id c15so5626955qkl.2
        for <cgroups@vger.kernel.org>; Fri, 17 May 2019 18:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sX2gtiM1F/1BEzdGKla5dDrkWxKhhFTMd4O/Z6SAzBo=;
        b=qUY01mlSmX4DbsPDMJaYgJn3Q/drbMkfzs7GJn39QrYDuj43qSb92iwS/7+dfV4fsA
         0E8GL5YXkNLl9QevERwZcDsUAahh7V23GHEc/jHP/nvE1FZj5aNfpsurZLUN4ZiGXEJ/
         kEGUkzJ+KOKblkBelAf19+5XJ3k0XULDRxrpj2mX4ZCwtT2ZBYUMR0dBeAsyWuZJQaWX
         7G4Sw6HuNpB8ZG8ZF69Ylb2U1935CrzrJkcIIgF0d3O/0dSo/MsxvOblfCa25GbkuF5l
         FtduQ6ojspDQKSXBdEZqZ/+4SZgnNdMSP3FQ17kAMAVk3BPNG8wNhbPTRYDyYt+rrFxq
         Z90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sX2gtiM1F/1BEzdGKla5dDrkWxKhhFTMd4O/Z6SAzBo=;
        b=A1W2rnN/NrhlZ7ReXpJY9WKr0Z03okLSvEMN55x3LxuOeb5lDctkHczG4ueG2hfthv
         1iDBLWCEgHpEMANTwctzlNE6fhdnlbP7GrCGh9zpdHhZkjsNegRyAobqfP0AvsbF9N5b
         AuSfvgLyWIZsonzYHC9JC/4nHQPM6IyWi6+OLl0tBR3GqiDx0JCgQA5jDVMeOHCBlURi
         7q2McMQYlHd+hUzhcXlvNbKUhwTD4PqHoaupRc3wxcEcajkGt9TR/cR6vX0mukb7IAL3
         zl1WTv8r4AAqJy7h1pl1AyfiF9TPSWUrByZUSek5lY3fT5h6NqsEw6J+UYCW1mKCBvIL
         zi1Q==
X-Gm-Message-State: APjAAAVK4JLrJI9abi6ztxYokiuOYzFi9LAwfvrU4yO0O/cY5lsmLUBd
        KeP1aT6nH35OdZBStiAneJQ/EA==
X-Google-Smtp-Source: APXvYqwf0oihuMDsTfVgR6ZJ1VQoL7rw3UIuUWL4s1dxZcgaqafC88Kcarb02I8LUJo8ZbVVwPDEsQ==
X-Received: by 2002:a05:620a:1232:: with SMTP id v18mr48607219qkj.27.1558143230592;
        Fri, 17 May 2019 18:33:50 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id z29sm5166322qkg.19.2019.05.17.18.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 18:33:49 -0700 (PDT)
Date:   Fri, 17 May 2019 21:33:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        tj@kernel.org, guro@fb.com, dennis@kernel.org,
        chris@chrisdown.name,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
Message-ID: <20190518013348.GA6655@cmpxchg.org>
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz>
 <20190516175655.GA25818@cmpxchg.org>
 <20190516180932.GA13208@dhcp22.suse.cz>
 <20190516193943.GA26439@cmpxchg.org>
 <20190517123310.GI6836@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517123310.GI6836@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 02:33:10PM +0200, Michal Hocko wrote:
> On Thu 16-05-19 15:39:43, Johannes Weiner wrote:
> > On Thu, May 16, 2019 at 08:10:42PM +0200, Michal Hocko wrote:
> > > On Thu 16-05-19 13:56:55, Johannes Weiner wrote:
> > > > On Wed, Feb 13, 2019 at 01:47:29PM +0100, Michal Hocko wrote:
> [...]
> > > > > FTR: As I've already said here [1] I can live with this change as long
> > > > > as there is a larger consensus among cgroup v2 users. So let's give this
> > > > > some more time before merging to see whether there is such a consensus.
> > > > > 
> > > > > [1] http://lkml.kernel.org/r/20190201102515.GK11599@dhcp22.suse.cz
> > > > 
> > > > It's been three months without any objections.
> > > 
> > > It's been three months without any _feedback_ from anybody. It might
> > > very well be true that people just do not read these emails or do not
> > > care one way or another.
> > 
> > This is exactly the type of stuff that Mel was talking about at LSFMM
> > not even two weeks ago. How one objection, however absurd, can cause
> > "controversy" and block an effort to address a mistake we have made in
> > the past that is now actively causing problems for real users.
> > 
> > And now after stalling this fix for three months to wait for unlikely
> > objections, you're moving the goal post. This is frustrating.
> 
> I see your frustration but I find the above wording really unfair. Let me
> remind you that this is a considerable user visible change in the
> semantic and that always has to be evaluated carefuly. A change that would
> clearly regress anybody who rely on the current semantic. This is not an
> internal implementation detail kinda thing.
> 
> I have suggested an option for the new behavior to be opt-in which
> would be a regression safe option. You keep insisting that we absolutely
> have to have hierarchical reporting by default for consistency reasons.
> I do understand that argument but when I weigh consistency vs. potential
> regression risk I rather go a conservative way. This is a traditional
> way how we deal with semantic changes like this. There are always
> exceptions possible and that is why I wanted to hear from other users of
> cgroup v2, even from those who are not directly affected now.

I have acknowledged this concern in previous discussions. But the rule
is "don't break userspace", not "never change behavior". We do allow
the latter when it's highly unlikely that anyone would mind and the
new behavior is a much better default for current and future users.

Let me try to make the case for exactly this:

- Adoption data suggests that cgroup2 isn't really used yet. RHEL8 was
  just released with cgroup1 per default. Fedora is currently debating
  a switch. None of the other distros default to cgroup2. There is an
  article on the lwn frontpage *right now* about Docker planning on
  switching to cgroup2 in the near future. Kubernetes is on
  cgroup1. Android is on cgroup1. Shakeel agrees that Facebook is
  probably the only serious user of cgroup2 right now. The cloud and
  all mainstream container software is still on cgroup1.

- Using this particular part of the interface is a fairly advanced
  step in the cgroup2 adoption process. We've been using cgroup2 for a
  while and we've only now started running into this memory.events
  problem as we're enhancing our monitoring and automation
  infrastructure. If we're the only serious deployment, and we just
  started noticing it, what's the chance of regressing someone else?

- Violating expectations costs users time and money either way, but
  the status quo is much more costly: somebody who expects these
  events to be local could see events that did occur at an
  unexpectedly higher level of the tree. But somebody who expects
  these events to be hierarchical will miss real events entirely!

  Now, for an alarm and monitoring infrastructure, what is worse: to
  see occurring OOM kills reported at a tree level you don't expect?
  Or to *miss* occurring OOM kills that you're trying to look out for?

  Automatic remediation might not be as clear-cut, but for us, and I
  would assume many others, an unnecessary service restart or failover
  would have a shorter downtime than missing a restart after a kill.

- The status quo is more likely to violate expectations, given how the
  cgroup2 interface as a whole is designed.

  We have seen this in practice: memory.current is hierarchical,
  memory.stat is hierarchical, memory.pressure is hierarchical - users
  expect memory.events to be hierarchical. This misunderstanding has
  already cost us time and money.

  Chances are, even if there were other users of memory.events, that
  they're using the interface incorrectly and haven't noticed yet,
  rather than relying on the inconsistency.

  It's not a hypothetical, we have seen this with our fleet customers.

So combining what we know about

1. the current adoption rate
2. likely user expectations
3. the failure mode of missing pressure and OOM kill signals

means that going with the conservative option and not fixing this
inconsistency puts pretty much all users that will ever use this
interface at the risk of pain, outages and wasted engineering hours.

Making the fix available but opt-in has the same result for everybody
that isn't following this thread/patch along.

All that to protect an unlikely existing cgroup2 user from something
they are even less likely have noticed, let alone rely on.

This sounds like a terrible trade-off to me. I don't think it's a
close call in this case.

I understand that we have to think harder and be more careful with
changes like this. The bar *should* be high. But in this case, there
doesn't seem to be a real risk of regression for anybody, while the
risk of the status quo causing problems is high and happening. These
circumstances should be part of the decision process.
