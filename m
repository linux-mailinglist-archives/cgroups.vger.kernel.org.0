Return-Path: <cgroups+bounces-13480-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHKRCZcBeWmOuQEAu9opvQ
	(envelope-from <cgroups+bounces-13480-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 19:19:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D198ED2
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2503014416
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B16326945;
	Tue, 27 Jan 2026 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdesbTw8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B6325726
	for <cgroups@vger.kernel.org>; Tue, 27 Jan 2026 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537940; cv=pass; b=XGJU+4O4t+ynKpdiDNB/r7FqU9PjPgdRFNI9vPEM30LwJOmC+JpPGiycZWNlg2EEKXk6cJc4fPxm9HdqmaZMkNYbtVRnrRy+eBeKlF9k7LBglMl7RrCeHhnYaIbVS3RTrBsIIzJSd1fpgt2gvMIBf8vqBgmHOJ1pc0DEPGBHeNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537940; c=relaxed/simple;
	bh=Yatq7weziuwxKIhpWbQPvvtWU6yVQhgZw5EKNN3WZco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoqIY7TWdG1tetgPkJ+NXjkMfakrNfYr1Dx7i53+c6vFD5ebClwUHedjZ7OAvYmBwh4QFUheAnmMc/dfRGJoVfj6Iz5N/mAHid7nZSQT93yPTf5xPbggT0N0/yToeNaCGpHezl7f1RmG3UYDHdj3zQJ4UdHRsY2LYQwA3HYKwb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdesbTw8; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b885e8c6700so774589266b.0
        for <cgroups@vger.kernel.org>; Tue, 27 Jan 2026 10:18:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769537937; cv=none;
        d=google.com; s=arc-20240605;
        b=RFZQZU3vltk1GorJWlqdaxmnmM5DeXrHaR1uDxem3+yKCczlVytkgH9q32DuYU3517
         1I+TqWlIhcWpQ56ZuXfVmOOtgKU3c41EkF1cFXMg6WJSxdVbqWktfZU2ndt78RyU6Qep
         7w1S17E/YUOmSR3ZceAA2LTT3e2facnBpq1kVgzpwcfv/EE6ZDHARj9oYiRLh5D1Jt5J
         iKYryH1Jdsp4wgoE3FR13Cl+76yhVUBr/uG2yKKFSBWw9PRuUjXA1+Dd96rCtYs9Ku7b
         6tocJ0O7m/JoqjWUwSInOGBfbsX9HblTSCk1YQGq01Mw1gUeSI0gMaemrGWGZx3qHseY
         /tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GG7557URwK0UXTCrQp6ABL8Oh2EUU6sQE6E22jfPw30=;
        fh=E59WljzRkImKs5gXxj6DGwSsOH1OK2NtID9BuBWPPyY=;
        b=E4tKRPU72rhzJCslPM5xcl0zHvVrD07ayUf1az+nNLFFpIibvwChjKVE3vobwpTdL9
         FoekUA2NdYVTASk5P42hbILF5HjDTXLRKRDDoLa8IAIrMAOYSpqxJJKlchsgJ7tfreT8
         dnTlReKsUjqkD5Tu4JFV7ckbYC/91sN319NSkDLSms5q8YZRy7r9sAQgCp4JqRLoXYua
         ovnGlnRUhwb6DLcBCB9ellaxOQGeQiSkcjcA5AOA1hm1eWaGxF67Q+uqWMvRGu3PRBoM
         TeYniDsHtO8xDguokFPNTyq2OM21PtmND/9Nj4+NO4JR96mZ5COkh+q3gcPbEUpsnSS/
         IyuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537937; x=1770142737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG7557URwK0UXTCrQp6ABL8Oh2EUU6sQE6E22jfPw30=;
        b=MdesbTw8YEqE3c/b8LOZ3INcoikX4oguc3mRiRiiBaZVvkye8BdWrSM7oQdcD6XeOS
         hif9wmolDEcoLMJPjqS8wfz+wbCLmlhvSoWxcLKkSJJQt63pFNhpgF8vW9y3fzXwXwYr
         d8ZiXtDx5qDpMK2gOkXI03cl/8daqqN67beikNqUHmiIZDN297L5U1lrwu42Prma/pma
         15aStlBnB64GVDvl7Q2nmxzyJMsK0ZlR88mlUAiRUko/FVBsBj6YcIS3053h5UWVK/09
         1WDIdG682fpriVqOPrKFpC7kmISSuw6dx0cMPzXUK8Mxap0+eL1WewP472BwJJda5Six
         Lm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537937; x=1770142737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GG7557URwK0UXTCrQp6ABL8Oh2EUU6sQE6E22jfPw30=;
        b=EZpicFmquCkVZnKqVU5mHnHaugCyF4lIxGtPx+heTaYcbg1zmiKxegjEfioWnhTOhm
         pGpgWs+GF/p4U63l5bs+ynomWk4g+gt8V1Ykr+6IbutJUBjPsB6RdHzXpKljA+u7m2pV
         6wokHdbaNlEFozXoXPThU0JxXg69KgUOw5UuhfnrvtyMnqvFKRgDIBkxsMH3Uz/l++fY
         K1IAB6aI4nlpSuybW9pgoXf4ON1F5akkCIcLP4qyH65Xngo1uvNCIS5OFKyv1ZMxUPEc
         vnuYFu/DOiauMwwPKWCMS3Ednm2n8ZBPEZv2j5ZMdM2hbLSERRnBmaoAVUb/LeaRXANV
         EKNg==
X-Forwarded-Encrypted: i=1; AJvYcCXrA8LFgIUudp1nnXHu3ctOn4qjC/yg2BvIGXqbOT258kwoUt7Xj7jV5CzgFlmGAX/jcR/mrIxS@vger.kernel.org
X-Gm-Message-State: AOJu0YywwJQ+K8Fc8ZpS6rOSgMirtc1vCJ8JPdymws/g4uIgT+HMBUeZ
	icTM9HoRNR132kpzU5R/72+Sng5pc3Gb4SOKS9uoogCXcCMPPzlHCs/cHH01HvSojXZrCgIQ66T
	isrMUP4xRUueLT+lbd2OtrWGUGotxAPU=
X-Gm-Gg: AZuq6aKnrtr/kTQCXaOZ5sAT1QHN9dy2z/VsfJRtphlOu0mSyFkn+heA8LGZT9edD1A
	oPOhjKVV/5sQI4dkj6VDpbpHtVBLRYfNtGric90X4EQ/bVQu+2tYk1VXfVp1sYkl3ihsgS6/468
	nqV4LXRHQCh/B0EKWgzcKqJcFFUg6A5RH0brtx7+YMIlqsGp709lwvxs3QFNifChXolUBK8i+rm
	fKmCV0Zwgot8CmInC0Yyt6nejXt9VIqKbYgbkwsG09DMk1pDVAFgNiYD+Z339xusjCG1DLMP0V6
	+hCUT6ZdmejbbEIcHMrDpg0+EEM=
X-Received: by 2002:a17:907:1c85:b0:b88:21cd:5fcc with SMTP id
 a640c23a62f3a-b8dab420b11mr190916766b.36.1769537936992; Tue, 27 Jan 2026
 10:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122112951.1854124-1-mjguzik@gmail.com> <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
 <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
In-Reply-To: <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 27 Jan 2026 19:18:44 +0100
X-Gm-Features: AZwV_QilNK6Vap6aeIYcYb_amovMbojm-c6woLpKl6DwoY7GKxouQgAaBV1yuHU
Message-ID: <CAGudoHFaUjm7_Eh6VOOGvfscdekk7v2uNPjfLkZfAkR9aCA1Ew@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13480-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8D1D198ED2
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 6:27=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Jan 27, 2026 at 03:30:14PM +0100, Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > ping? I need cgroups out of the way for further scalability work in for=
k+ exit
>
> I got stuck on following:
> - possible implementation with (simpler?) rwlock,
> - effect of css_set_lock in cgroup_post_fork().
>
> I want to try some measurements of the latter since I assume that
> limits the effect of the elision in cgroup_css_set_fork(), doesn't it?
> (IIUC, you'd see it again if you reduced the pidmap_lock contention.)
>

Not sure what you mean here.

If what you mean is merely converting css_set_lock into a rwlock  and
read-locking in the spot handled with seq in my patch that's a no-go
-- frequent reader vs writer transitions kill perf in their own right
and you still have 3 contention spots, i.e., this will remain as the
primary bottleneck.

To reiterate,  in the kernel as found in next at the moment top of the
profile is still the pidmap lock.

There is a patch to remove most of the overhead under the lock:
https://lore.kernel.org/linux-fsdevel/20260120-work-pidfs-rhashtable-v2-1-d=
593c4d0f576@kernel.org/

It may need some tidy ups but for the purpose of this discussion we
can pretend it landed.

With that in place top of the profile is the css set lock.

With *this* patch in place we are back to pidmap, which is then
followed by tasklist.

clone + exit codepaths are globally serialized as follows:
- pidmap -- once per side
- tasklist -- once on clone, twice on exit
- cgroups -- twice on clone, once on exit
- some lock for random harvesting, can probably just go

In principle with enough effort(tm) one can introduce finer-grained
locking for all of these, but I suspect it is not warranted and I'm
not going to do it, especially so for the tasklist lock.

So I very much expect the clone + exit pair will remain globally
serialized, it's the question of the nature of said serialization.

I think a sensible goal is serialization at most once per side (if
possible) and even then sanitized hold time.

The tasklist thing may be too problematic to only take twice, but even
then I can trivially reduce the hold time. If 3 spots have to remain,
it will be the new top. If I work it down to two, who knows.

So ye, css very much can be considered a problem here.

This comment:
> - effect of css_set_lock in cgroup_post_fork().

... I don't get whatsoever.

Stability of cgroup placement aside, to my reading the lock is needed
in part to serialize addition of the task to the cgroup list. No
matter what this will have to be serialized both ways with the same
thing.

Perhaps said stability can be assured in other ways and the list can
be decomposed, but that's some complexity which is not warranted.

