Return-Path: <cgroups+bounces-15924-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDFkHysnBWq3SwIAu9opvQ
	(envelope-from <cgroups+bounces-15924-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 03:36:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244853CC06
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 03:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B5C3302F76F
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 01:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6731ED7C;
	Thu, 14 May 2026 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGo4vDaM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FE31E840
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722600; cv=pass; b=UC9slzAbnmmbmzxznO7xVctd6T1Mwk6ipZ5eEUyBGQedT1r4LpXpZ7b/CakRZ+vFmJangMxvID7eOjHl/iJQN++iNR35KWHy3cTDo3PaOkBstgm9P2O/JKNAGzd4KG8H1SYlklAECIDnPivWVajVMjJD97+Z7yEHiqNhXdxiJpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722600; c=relaxed/simple;
	bh=Bx63wQK/dLfFiGwXscuCBUwEs/wx/605mPG3tTesGqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ce3tbYqUodCgnm9WWl7MsJ150dp8lI8Fl+rwKYkjSjItT8XBG9/2IvyEq5tYX/Fu1TPx2pHy+qv+Idyev1b1rjKcdbPmJlQ+qqIBPhWJT2K4Gj6Ph0AwvTUN4KfV2yljZdCfrOvvdA1cG6HLu6nu/qGMyAMFSkHzsOSfuLF29nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGo4vDaM; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1329fc4bf77so159972c88.1
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 18:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778722598; cv=none;
        d=google.com; s=arc-20240605;
        b=kjzTM1zTu1O6+nSPQ/kRewTx2/Rf2WZE+zWJezNXQQJrmWSReekkLGfsUhknzVN3Yj
         uQk5sYWdi7uugio3o+cidASEScYQ8I05ULcozIgOLuOVoGXZk9f0ADwJZVLDLMGECOBh
         g10DEoL0TNvDN+zq2EK08ylG7kzvXZF6LqB6G7S6zQ82BZVYrYErHBNDwkoVdpYcexWN
         KS6A/QjnSf2m/mPehxWikGYtFOTxemRTyzgAuNiOX+5SLrkYdM/2Jxy3aG3lhu00pPGk
         sHd+o9QHqStGm4lgqoy3iDWGYSFN/g7IlVyEjFixQzgc7a5EksVUpKoEnuUIUcEcVzdA
         Ns/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZEH9v8Rjc8efpJ4WwSjt3IUcl27Na7rmXqWgvC4OtAY=;
        fh=qYkpDut8yWKkUKYz5GpGiphExlR4+5p4/JUw+L/zc50=;
        b=YFoYzDshUaMaO2TUG1NYqN2Cxi0ZIpPVrjh1VeQ7qS7x02lEsJHfLLetj4iacuGXIl
         ttghA/Ys9bWSPkobqN3qXwb2RZazVgWI8POo1X6fxK59ivNLvjp75ZX4saN8j00FGcch
         KLWj6A5aHteUznSS9o2dNg0uPWInkYPUo9QzKLyZb2TUk2xFCz09rHcoGgwF9oj/dKef
         S5Ixu8nf1B/GCr8/TUt9Bb1JzzRbNKEDm1BwcURc2twmzEqZXcM+9k65C/r7Duan4geb
         ISlWUSbxnn9tcuwVVbvFXqKB83Ds+VHsmEl+NWBjaAH1BmK0BgVrnYeARJNKLt3aZFh7
         o/Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778722598; x=1779327398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEH9v8Rjc8efpJ4WwSjt3IUcl27Na7rmXqWgvC4OtAY=;
        b=tGo4vDaMDcPc65ZHx/D/nAClU3V4t/GbiwGdsjr3Hj9Os3BpHMFsZ/i++BMLgpPSE+
         zm8dzVyUEtySaYDH2ww3DNOwtDwcoGDTZKV0s64vvz1J7Do1Lcf5lW4x8f4/Kgkk1bK5
         cKn3VVGpf61xr0k3dlHVqJYfsegR9S6G+Yf6cCVl91NB4ymO6/iaSdov5zJ1h68Fdtwx
         2edSiiO8pOGMRoxKGvU/D2E9Az8AOUcyd4SV+/i+lYu/lC4crlAq1lbAmQ1CBqoZ2Ln3
         ed8vFBF+CzYrARv8WrAM22jQfWIBXc0FfxEpxwU0UmHsz6viAot+cPjqoPncQAFETCww
         1KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778722598; x=1779327398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEH9v8Rjc8efpJ4WwSjt3IUcl27Na7rmXqWgvC4OtAY=;
        b=BEEUz0dogPcF0rRo+70sNgmYQuW9HxwOFeomYPBaKinT8tLvmL90NvWb5XzmG5VZQS
         HvzWSGXZAhQWy4BiBaNKky7HKXgr+Zmuk0eywBX0/EMc/wvIp0cl4cH0dwZXS28WetxZ
         30ptNBFt9BDGLGVWko98/BS2pvspFQ9piCwg+8r0sMsQUYqAhST/OJjMPOJp/tU+n6A/
         0oJQ1+2Hb7SsVi9HFXpS09tivF7TVlSVZq1KEEsJD3V/7KUp3cmxWBjNr72TPfRqjs3j
         hdYDN2Kud1ZCYUBIgrY8lFOgaQtdhGPXnZgSuS5amlvclKQLTa/ZnpGJs17WMUIOja28
         YeDw==
X-Forwarded-Encrypted: i=1; AFNElJ+2eGTDcsVQqbp8Z8x3OpKmcaRzmgkNOFF7OSHeoVq7/28Dvoly6Hm3EeEf5SrLytIHL4n92Omq@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9qsh9LhVd8rEjamqweil2LofeFZYe6RGCTw0pAvPrYXZZwCg
	Ruh60LsWbXA7IfPaZWo6DQ3Xr89CwQOwumXQ0T5UxveTRNowZ2iDWzWmxgzBx4DZ4CSNaalWh/a
	iVkMgflhNtkyhC1ybWgy1e7v/f9RU4h7sMFHKHuI=
X-Gm-Gg: Acq92OGzWWFwaGUSf54Gx9uQkUr7wTLq7kswOcJbCwHdNEN48sEB5lDVCrEmSPrIor6
	prsSF0luOZfJfnY41GmB97ItR1nvoIp1BvTkqk5UBV/1QWbuTijDeETmj9hFr5h8qQ3AhgwuKls
	SJkz9ehC6iG0+zx39aJYydSyjD0q60xo28DjX+MMGYpJdlZwH7krb1SdOJfJQDeCnw4KQsBntxO
	yblMwSbuNYeH/o4B7rnGLWxxx+kEHYYeyhI4wtufId7LB8lmLuFTLBy3ZZ8LGxkWCYokJHRcMtK
	wrxAnOvF5109DYlvFKLUgbvBgGUsvDObhkbPRmPWSANQxG2jIyDlDXPMtp8yG3LTruEGhm5CMDz
	PQQnfTjWiDC7rt39qovNQKo3K5YtF22zJ/qckvC4KWDoV1Q==
X-Received: by 2002:a05:7022:691:b0:11a:e426:911a with SMTP id
 a92af1059eb24-1342ef45730mr3376146c88.15.1778722597633; Wed, 13 May 2026
 18:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.206700041@infradead.org>
 <CANDhNCp1rcNYg29Fe66G6cuqHhDyXQ0oqccheSwfMuiNV-7Bgw@mail.gmail.com> <CANDhNCqWJ=Q3LxazK_ioo_39aFfR+yVbPEV+MQHC8_QvadhuTg@mail.gmail.com>
In-Reply-To: <CANDhNCqWJ=Q3LxazK_ioo_39aFfR+yVbPEV+MQHC8_QvadhuTg@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 13 May 2026 18:36:26 -0700
X-Gm-Features: AVHnY4J6T9HAANrp0kIY2IKkXIXPDZagx9-HL7rdfBk-KGgX5EGRtBGBtzVHn-g
Message-ID: <CANDhNCqsZVsWygBA7m2F_w2r3DnQkFDXfd95Lc4ny-zjQQE7Qg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1244853CC06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15924-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:00=E2=80=AFPM John Stultz <jstultz@google.com> w=
rote:
> On Tue, May 12, 2026 at 9:51=E2=80=AFPM John Stultz <jstultz@google.com> =
wrote:
> >
> > On Mon, May 11, 2026 at 5:07=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > Change fair/cgroup to a single runqueue.
> > >
> ...
> >
> > I know Vincent was having some perf troubles with this patch, but
> > booting on a 64 vCPU qemu environment, I'm seeing:
> >
> > [    5.688490] Oops: divide error: 0000 [#1] SMP NOPTI
> > [    5.689457] CPU: 47 UID: 0 PID: 0 Comm: swapper/47 Not tainted
> > 7.1.0-rc2-00026-g82a8ec6fb3f9 #38 PREEMPT(full)
> > [    5.689457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > [    5.689457] RIP: 0010:wakeup_preempt_fair+0x1b7/0x430
> > [    5.689457] Code: 74 0b 48 8b 52 28 48 39 d0 48 0f 47 c2 48 8b b9
> > 90 00 00 00 48 8b b1 08 01 00 00 48 81 ff 00 00 10 00 74 09 48 c1 e0
> > 14 31 9
> > [    5.689457] RSP: 0000:ffffc9000021fd70 EFLAGS: 00010046
> > [    5.689457] RAX: 000002ab98000000 RBX: ffff8881b8e2db40 RCX: fffffff=
f83022a80
> > [    5.689457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [    5.689457] RBP: 0000000000000001 R08: ffff88810cb14380 R09: fffffff=
f83022b00
> > [    5.689457] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000002
> > [    5.689457] R13: 0000000000000000 R14: ffff88810cb14300 R15: ffff888=
1b8e2da00
> > [    5.689457] FS:  0000000000000000(0000) GS:ffff888235c2e000(0000)
> > knlGS:0000000000000000
> > [    5.689457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    5.689457] CR2: 0000000000000000 CR3: 000000000304c001 CR4: 0000000=
000370ef0
> > [    5.689457] Call Trace:
> > [    5.689457]  <TASK>
> > [    5.689457]  wakeup_preempt+0xa8/0xd0
> > [    5.689457]  attach_one_task+0xec/0x150
> > [    5.689457]  __schedule+0x1ad8/0x21c0
> > [    5.689457]  schedule_idle+0x22/0x40
> > [    5.689457]  cpu_startup_entry+0x29/0x30
> > [    5.689457]  start_secondary+0xf7/0x100
> > [    5.689457]  common_startup_64+0x13e/0x148
> > [    5.689457]  </TASK>
> > [    5.689457] Dumping ftrace buffer:
> > [    5.689457]    (ftrace buffer empty)
> > [    5.689457] ---[ end trace 0000000000000000 ]---
> > [    5.689457] RIP: 0010:wakeup_preempt_fair+0x1b7/0x430
> > [    5.689457] Code: 74 0b 48 8b 52 28 48 39 d0 48 0f 47 c2 48 8b b9
> > 90 00 00 00 48 8b b1 08 01 00 00 48 81 ff 00 00 10 00 74 09 48 c1 e0
> > 14 31 9
> > [    5.689457] RSP: 0000:ffffc9000021fd70 EFLAGS: 00010046
> > [    5.689457] RAX: 000002ab98000000 RBX: ffff8881b8e2db40 RCX: fffffff=
f83022a80
> > [    5.689457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [    5.689457] RBP: 0000000000000001 R08: ffff88810cb14380 R09: fffffff=
f83022b00
> > [    5.689457] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000002
> > [    5.689457] R13: 0000000000000000 R14: ffff88810cb14300 R15: ffff888=
1b8e2da00
> > [    5.689457] FS:  0000000000000000(0000) GS:ffff888235c2e000(0000)
> > knlGS:0000000000000000
> > [    5.689457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    5.689457] CR2: 0000000000000000 CR3: 000000000304c001 CR4: 0000000=
000370ef0
> > [    5.689457] Kernel panic - not syncing: Fatal exception
> >
> > Which I bisected down to this last patch in the series.
> >
> > faddr2line gave me:
> > __calc_delta at kernel/sched/fair.c:290
> > (inlined by) calc_delta_fair at kernel/sched/fair.c:300
> > (inlined by) update_protect_slice at kernel/sched/fair.c:1070
> > (inlined by) wakeup_preempt_fair at kernel/sched/fair.c:9193
> >
> > This usually trips as the ww_mutex selftest starts at bootup.
> >
> > Unfortunately I still see it with the add-on changes you proposed to K
> > Prateek's feedback here.
> >
> > I'll try to narrow it down further tomorrow.
>
> As karma would have it, this does seem to depend on CONFIG_SCHED_PROXY_EX=
EC. :)
> I'm guessing the switch in calc_delta_fair() to use se->h_load is
> uncovering something proxy isn't handling properly with that value.
>

So looking at the callstack when I see the failure:
proxy_find_task()
  proxy_force_return()
    proxy_resched_idle()  <- sets rq->donor to idle
    attach_one_task()
      wakeup_preempt()
        wakeup_preempt_fair()
          update_protect_slice() <- called with the donor's se
            calc_delta_fair()
              __calc_delta() <- div by zero

Basically we end up in wakeup_preempt_fair() with rq->donor =3D=3D
rq->idle because we earlier called proxy_resched_idle().

Without proxy, if we call wakeup_preempt_fair() when rq->donor (and
rq->curr) is rq->idle, we usually end up taking the `if
(test_tsk_need_resched(rq->curr))` early exit and we don't hit this.

But with proxy, rq->curr isn't idle at this point. So we end up
continuing on. Despite the se_is_idle(se) checks (where se is the
&donor->se), those don't catch because rq->idle (maybe unintuitvely)
has a SCHED_NORMAL policy.

So we end up getting down to update_protect_slice() with rq->idle as
the se and the idle h_load.weight is zero.

Not sure what the best approach might be, but adding:
  if (donor =3D=3D rq->idle) {
    /* don't give rq->idle slice protection */
    preempt_action =3D PREEMPT_WAKEUP_SHORT;
    goto preempt;
  }

similar to the `if (cse_is_idle && !pse_is_idle)` check seems to resolve th=
is.

Anyway, if you have thoughts on better approach, I'd be happy to work
up a patch to add on top of this one.

thanks
-john

