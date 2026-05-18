Return-Path: <cgroups+bounces-16030-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMsBC/0DC2qj/QQAu9opvQ
	(envelope-from <cgroups+bounces-16030-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 14:20:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9891056C7EE
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D951B30D7EAE
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FBB3FD14B;
	Mon, 18 May 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLyg4H6W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXRKsefn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53D3FCB18
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106026; cv=pass; b=uRcMPYdVnHeiO9hwcpY1WOjTy2ZEh/JcmsS+sI+tQOXBkVLCPeLlJR8yOgG4dGDorS+l23i0pceWM2D/liwC15Rwr9dqz96SO6E4zcJaDqOBCyAUvg9c1/dOMTdDJ7M65e1uguh53VsJKVRPBXuXCO3zGa/ZwuKz+HLP6Hr7/s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106026; c=relaxed/simple;
	bh=EAOhdahq1wTYoi+v3Sd0YHLgR6nzuu2wluSY7LEs20o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNq1lGn6iTfesop8CzOggIoFnDEqCGKZayWxAdN/t3LaaDZEwfnb3JvI5u/ZiKHWQVQv55nPIb2Ve+AaxsbCnSI0wljZ43rRXd+/5loAsG9UfDfm1z4KtZqrbAx5mMlLF7WGJn+SwEMNi+UvXTX9oHi1JJrEZfbV5J+7q/3tpVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLyg4H6W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXRKsefn; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779106020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAOhdahq1wTYoi+v3Sd0YHLgR6nzuu2wluSY7LEs20o=;
	b=GLyg4H6W1yRhjE8OsNUbVkv2u+oevWCtJ9jGz0FuDXME/PMauUJI3kgtLuLJSvfzYYfdqN
	tizhyuR/gL9TELWoW/0Li2d7AYVmKOG01oFnoiMevjL7RXSZlhWy1l9d5lirBc3Mr+ED3/
	Eep4sLlrfKXOMGpdl17+A2OjVkj8RX4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-rLEXReKeMCeCS_fB_fQBLQ-1; Mon, 18 May 2026 08:06:59 -0400
X-MC-Unique: rLEXReKeMCeCS_fB_fQBLQ-1
X-Mimecast-MFC-AGG-ID: rLEXReKeMCeCS_fB_fQBLQ_1779106018
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd5c9e2e4aso30212587b3.2
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 05:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779106018; cv=none;
        d=google.com; s=arc-20240605;
        b=DDap7+eQXeVW0NXUbFbbPaDPja+5OW+IZEXASPs4rKmXiSR/ETx25oI0Wkh873LT99
         eqmLWNs/F2gFAA60tQE5ozttVevfwF/uXrk7yhguy+qdAFfwb/7STDt+4nA1WtQlz2v7
         6JQxrEsNRG8OqlwqLSuX1wQGEyqPsqIONNz0uOTGt4vY7AQU1JVwrmUcLqK7vLPRAh/r
         3SRDzSKZhN7lXhkJVlWLevCWmwq1z+mWACeCyC+Iq6q69haRUKBxIsnvyWjOfAqM4ROP
         IEtgzL4ITL5htJhDO2aKULaY3jseERWcJ+/5GPa9kNnLzXuC1YdVpjN9HbdFm+ZRIQbW
         0JHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EAOhdahq1wTYoi+v3Sd0YHLgR6nzuu2wluSY7LEs20o=;
        fh=XOJzOXTGYQJgDcnbeRy9pmvp9HkeUqVX7qYopXqxjps=;
        b=cnmuhwZqiQlor8eFBxxmI+B2QNMkx4V+pE4LNCI6Rn+q4Xo+lL2Ce7bWstt84s2uU3
         K5ZFZBtvmD9os/HzDG/TYq639owaUl2qk/dXh2wmpTiirR7q/hiIJq8+W9v/8qJvbOsO
         cI5UpWDO9Wfr3ZZ4M5R48d+h7hwibvxFSgopCu64FS8+p9vCWsJMdSCqFQ+eDpO7/U/4
         KrQZ99xj91foOyF6z+F/DkzSQwsd4iA21mS2XAqXaIhbSdvPokh4Tjtyxaso0Unwm9qZ
         /NdTlRKY+AokDullCjddBCbs9EPkbo/ILoE2VpU5jn4bOQA/TjNuV3utB0uAmZzQC1Ex
         EKOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779106018; x=1779710818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAOhdahq1wTYoi+v3Sd0YHLgR6nzuu2wluSY7LEs20o=;
        b=BXRKsefnGCMXMhgisrd0MC7Rs/auGleOXoRdtovMvOZlz8JJE1sPikdDhxXtmkWdr4
         /bR5Nt++ZHSOPzEGG8kIY9AOtowwgbNrnZNJT7Y6W0seh1k+P9T6nEGXlvx4bRcI/8eb
         uRRHMtOFb3JcOzXyIK10B/cJAuPoJY0qdSzZ6sCVNfj54b+HQ3HFZbzPQ0hjx7zlOqA7
         an8qq4u22GOl/cyqbd55SH39Y9RLLNTPjU5iCMDhjxvuMlak4x41FhiunXT6fZP/Gtdt
         D75/+eSFwmAZgP5xdE2FoVW7eokz5kyr1zHwu/5Z+MEDZzdcYLOF2T+EslGzUT2ojgbm
         D3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106018; x=1779710818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAOhdahq1wTYoi+v3Sd0YHLgR6nzuu2wluSY7LEs20o=;
        b=nMCqiHDwfQe98n0GaO4dSMJFlFRCeSl//CwIat1TaQHF4usc3J/an34fcCEmBaj5P5
         aj/7Us2LYFMsvoenTXmNRDGUZRuvk962TCKypYGSSXzpvNFoEIBr2JnWEnLL31M6pCOZ
         qz0G31FOBKyC6UBiw7XzpgTDiGoZVoaNa4uvJd2/H2XnSS3ZY0HG8cCZ6zcxnPfc5JIs
         VD2LBSxM/4XzYJnkCld9kJ3ZlPpCt0uwwCEJttioBjyZ/DOgfb0w/TADZqDZ1mm6gt+y
         6D4YAG5obrSMzNe82k30cI4pp1Ut6lGF+LLwf3tBfGHVvUYC77caK8XpB5aEQqKGm6C9
         /SXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xdr302PfWJW60F5H3X7aqRpZGbMmJ6N4wYnJXfG22DWJCE7E5P6MbTfv0RaVi7qKJQOwOHVdg@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhF61V3MC9vhtACS5usLI8LwGrVbm5ZSjPmqxi/TDhBqoyqdk
	K9LCf7Maw5EqGVeEi+KkLjqWwl6GrN6iMdKoxjdokSTOp1i/PFOUJpFPIQ5TaYwr8UvHWkYesK7
	3/Ggz3YFvbx3nSGdNMy40kL8tGWwXWcSH8BCQh5S+mI+7Kun3x7xeUeLn9sYNV+Ap5dTRH+MlHe
	Z8xPUhxsQ49ewmnaFxTAUV62PJ62BOJxt4vQ==
X-Gm-Gg: Acq92OHASyN5GpsIylFvEYuVUaqDVDETQFV2vvC+iwmB53fY4yUfb44lwT94oc0c2Qi
	e17sOqN3LtcDCmIXRvSZTDWoF1Z4e4OH4uOTo6sWmWd5WB8T/X+YVN54R3eKjRd8K/3PHuADeto
	BAZC3gJvoIZKwFA20yLZAoCF0qd3nAHLpBc0KuC52KKl/WD3I6An2bay5IBoS++JfB8rbxr/G1w
	K5GpA==
X-Received: by 2002:a05:690c:e3e1:b0:7c0:56f:5b59 with SMTP id 00721157ae682-7c9599a36ddmr149907217b3.15.1779106018427;
        Mon, 18 May 2026 05:06:58 -0700 (PDT)
X-Received: by 2002:a05:690c:e3e1:b0:7c0:56f:5b59 with SMTP id
 00721157ae682-7c9599a36ddmr149906897b3.15.1779106017837; Mon, 18 May 2026
 05:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com>
 <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
 <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com> <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com>
In-Reply-To: <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 18 May 2026 14:06:45 +0200
X-Gm-Features: AVHnY4K8qpVqb_W68zu-wX_-3BWWvVrVAC2CPBMHXBkSI4OOVylnoTOI9cwLMps
Message-ID: <CADSE00Lc42s2bzXzV5D7t1Enf56u4BVj-yXLp3Yxhm0=qMPvuw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Barry Song <baohua@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri- <devel@lists.freedesktop.org>, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9891056C7EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16030-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 9:34=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/16/26 11:19, Barry Song wrote:
> > On Thu, May 14, 2026 at 12:35=E2=80=AFAM T.J. Mercier <tjmercier@google=
.com> wrote:
> > [...]
> >>>> I have a question about this part. Albert I guess you are interested
> >>>> only in accounting dmabuf-heap allocations, or do you expect to add
> >>>> __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
> >>>> non-dmabuf-heap exporters?
> >>>
> >>> We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
> >>> controller are on the radar for follow-up/parallel work (there will b=
e
> >>> dragons and will surely need discussion). For DRM and V4L2 the
> >>> long-term intent is migration to heaps, which would make direct
> >>> accounting on those paths unnecessary.
> >>
> >> Ah I see. GEM buffers exported to dmabufs are what I had in mind. I
> >> guess this would only leave the odd non-DRM driver with the need to
> >> add their own accounting calls, which I don't expect would be a big
> >> problem.
> >>
> >
> > sounds like we still have a long way to go to correctly account for
> > various v4l2, drm, GEM, CMA, etc. In patch 1, the charging is done in
> > dma_buf_export(), so I guess it covers all dma-buf types except
> > dma_heap, but the problem is that it has no remote charging support at
> > all?
>
> No, just the other way around
>
> DMA-buf heaps can be handled here because we know that it is pure system =
memory and nothing special so memcg always applies.
>
> dma_buf_export() on the other hand handles tons of different use cases, r=
anging from buffer accounted to dmem, over special resources which aren't e=
ven memory all the way to buffers which can migrate from dmem to memcg and =
back during their lifetime.
>
> >>> udmabufs are already
> >>> memcg-charged, so adding a separate MEMCG_DMABUF would double count.
> >>> Are there any other exporters you had in mind that would benefit from
> >>> this approach?
>
> Well apart from DMA-buf memfd_create() is one of the things which as brok=
en our neck in the past a couple of times.
>
> But thinking more about it what if instead of making this DMA-buf heaps s=
pecific what if we have a general cgroups function which allows to change a=
ccounting of a buffer referenced by a file descriptor to a different proces=
s?
>
> That would cover not only the DMA-buf heaps use case, but also all other =
DMA-buf with dmem and whatever we come up in the future as well.

I removed a draft adding an ioctl for charge transfer from the series
before sending because I wanted to focus on the charge_pid_fd approach
and keep things simple, deferring the recharge path to a follow-up
depending on feedback.

The main difference between my removed draft and what you're
describing, iiuc, is scope and layer: my draft was an explicit ioctl
on the dma-buf fd that the consumer calls to claim the charge (see
below), while you seem to be suggesting a more general kernel-internal
function that could work across buffer types and cgroup controllers,
so not necessarily userspace-initiated? A kernel-internal function
will need a way to identify the target process, which sounds similar
to the binder-backed approach from TJ [1]. For everything else, the
receiver still needs to declare itself, which the ioctl accomplishes.

```
# When an app imports a daemon-allocated buffer, it can transfer the
charge to itself:
int buf_fd =3D receive_dmabuf_from_daemon();
ioctl(buf_fd, DMA_BUF_IOCTL_XFER_CHARGE); /* charge now attributed to
apps's cgroup */
```

[1] https://lore.kernel.org/cgroups/20230109213809.418135-1-tjmercier@googl=
e.com/

>
> The only drawback I can see is that DMA-buf heap allocations would be tem=
porarily accounted to the memory allocation daemon, but I don't think that =
this would be a problem.

The main reasons we moved away from TJ's transfer-based approach
toward `charge_pid_fd` are: avoid the transient charge window on the
daemon's cgroup; and to decouple from Binder, allowing any allocator
to use it.

Technically, both approaches could coexist, though. Of the three
scenarios TJ described:
- Scenario 2 is directly addressed by charge_pid_fd approach without
any transient charge on the daemon at the cost of one extra field in
the heap ioctl uAPI struct.
- Scenario 3 can be handled by the charge transfer function without
changes to SurfaceFlinger. The app or dequeueBuffer claims the charge
for itself or the app, respectively (depending on whether we include a
pid_fd field in the transfer ioctl). It also covers non-heap
exporters. The con in both variants is the transient charge window on
the daemon.

Both approaches shift the responsibility for correct charging
attribution to userspace: first, 'charge_pid_fd` on the allocator's
side, and the transfer charge on the consumer's side.

Deciding on one, the other or both depends on how much we value
avoiding transient attribution, and how much we need a non-heap
generic solution. With the XFER_CHARGE we can cover both. Thus, the
`charge_pid_fd` approach in this RFC can be seen as a
performance/strictness optimisation, eliminating transient charges to
the daemon at the cost of a permanent uAPI addition to the heap ioctl
struct, but not strictly required for correctness. On the other hand,
if we agree on the end goal of migrating other exporters to use
dma-buf heaps, and scenario 3 is addressed by adding the app's pid_fd
to SurfaceFlinger, then `charge_pid_fd` alone is a coherent/sufficient
approach despite the uAPI change.

>
> Regards,
> Christian.
>
> >
> > Thanks
> > Barry
>


