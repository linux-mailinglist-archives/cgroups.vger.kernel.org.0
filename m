Return-Path: <cgroups+bounces-13836-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPszD/Jii2nDUAAAu9opvQ
	(envelope-from <cgroups+bounces-13836-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 17:55:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781F111D754
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 17:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F8723027126
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CDD32274B;
	Tue, 10 Feb 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nzss0hL2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D331D375
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742508; cv=none; b=Y21yDhfms6V69bDpZ1SegTBoS6uGTjMGk0xJsmztqcfJ4BOnQRwcGJCB20hA8Rn6EnCg+9L1iQI1E2d0TQr/C15DsGVlPXjstThuTuldv9tneu70gR5cnvSftJC3udnMaZC+fQUR2ccTKLTY7epz4dhQU2d958RbwTtnzAyL5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742508; c=relaxed/simple;
	bh=VjtexQrrqgbXMQMwl6mFqhRnQqIBPa8W5pppWvjvY2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf7bOoY+tC7T+CnR0LqViF0OSV73x/+mzc9o6yo95xZzYbkSZztshv6DQ8rlF6J9b/NC2sDnVUt6TWOJJ28aFLgGGVjizCRptZh21TFCwow/kEN8R+xvJFwg36CWPEwgARv6adKRw9+FEqIW0aqgNV2qRhHf5ta8DVZcuJr3ZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nzss0hL2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43590777e22so2697773f8f.3
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770742505; x=1771347305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTOQY3r8OoiNYERfid1Bz8RThAITU1nPhvuRq4xQbV0=;
        b=Nzss0hL2YI7bY62qgdlyxoCUWwS1Oi5Xe4260F7gZo7VPFnhaLUZqaVL61Yb9dAkXj
         v1YQr91wKYoArSozJUgAmjLbA1UeNASHTmVW2SCihDmOfDQ54PREjs9HTKJtPJf8kSBg
         iNeuSBlzbNa+5YsnHdDDxTqwhuloWVmk4fXoCWqHE15OyA9L80shN0Fb5ovAzkdLP4af
         UVZJiDugWG0tL9DUx2ZJPyD1LQOLAJzHvP977XbhOntdyteig+QUltz9W45bgSRRh78j
         VTBD8EERDkyOptNA0yEuPcfZeg4bWGzrL3RDHlT/JRoyB+OKODJHCqdD2wRm9BelD2tY
         tMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770742505; x=1771347305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTOQY3r8OoiNYERfid1Bz8RThAITU1nPhvuRq4xQbV0=;
        b=Ahj4NNSR2qMxmztVOMy7WixmJ0ZB9TzA8kEWIs+2eCRYQSYdyjFj6vgrmobUi9oibz
         /zmNt0scMlqXqMQUXilfP5beqOB++9RUimRDQr0MoFjK1PeYmKAhWnJ+63FR5hMkjPCj
         7MqSogLm2rk0wK+WS8+Ydp/HqZ83bGW2CQwgnHlAQyT6hhrbjQXPKRTaF5qe2kOGpfI2
         OeH1wXtD7Kj2NpJU+vLcCvdcXEAc6gCcRWtpHbdOFAUSej4irAl2h8TCTnvJpRM2NL3r
         jXtxwqeWhrV42BXNLJJPk19iukw9qUyc5v9rIXpXU3UKrL5f2pwc3uwjufUmGq3PRhvk
         eyFw==
X-Forwarded-Encrypted: i=1; AJvYcCUynFmyZXszAMcagG0liSycrrrr5LQwlahkhYG6s7JzvCdocCw4XG5EhJZvyxoytLMbRKMh4l6g@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFRDySnuFlIRZyb154O/3JR8isJRsMQQ6FonpTURKElx+GWOX
	EMYXSePkQr9yf377SzKq+G9YPTm+jJYXXaECj1OTakDsaTmy60qz9LlrghQZcn1iIPT+tuBGFzc
	cJ5kE
X-Gm-Gg: AZuq6aI4D4mwnhdFYgFRG7bDoY+EEKlef+62veHnNkBl0fFGnZM9HQLqwnhyVU+YXyn
	ezobi3WlW9/rHvzn2Xv9PkO9dQucWHAOteYvsmZxJ5pogKF6EWZdWDJsLeBeWSF5e0JQOWDIKRm
	EUlrH8AvcLKvXSVtcWL6h7RhsV4nOarQLx2wsYXsiiRuAKDa/ZTYsCidmSPsBFDDr6lQD8WIDeY
	17y7Y+iSyZ63g8GIahgPdjWWmWdSE6Qgb5c2RVEk4PCBTS2vq0nT2eCP3Exm/CLNz0TdGlYs7gn
	CJ/1h072pF2miYJD2b6ivp12rpF7EKf3hDj7HbVsTJ+LRzUa314akyuh5Rq8tenzzyU94A7f+EH
	vlX+kY4UpD8yHV49g6giokI6ZZGupWV+1ZZxO+5GfBes2PbtprrA+qoWVgsiIvVTtEW8zQScZu8
	Y3S0V8fXuNXI5+j/gLw9sS/kMaTkVa5WyxSFQkbNlMX4phXg3ZJxYITA==
X-Received: by 2002:a05:6000:4027:b0:435:b068:d3be with SMTP id ffacd0b85a97d-436293b3a39mr24716414f8f.41.1770742505208;
        Tue, 10 Feb 2026 08:55:05 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2ed9sm36042984f8f.5.2026.02.10.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 08:55:04 -0800 (PST)
Date: Tue, 10 Feb 2026 17:55:02 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
Message-ID: <eu7erwjzoflxb7wzm7j3iitrwjoukajixasel2s3isfav4i3rv@ko2c2dtmnj2l>
References: <20260122112951.1854124-1-mjguzik@gmail.com>
 <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
 <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
 <CAGudoHFaUjm7_Eh6VOOGvfscdekk7v2uNPjfLkZfAkR9aCA1Ew@mail.gmail.com>
 <roisfgpkd7tapp7cfjavmih2e2riwh2nczv4nqk25gik7of4pa@3ohyptw6nvb3>
 <jt6kzvdkp4obq7jszyt4muc5ktjjft2idbz3mzkknlxdch6iit@yeumuxzp6gbn>
 <CAGudoHHuG-SCgv+F23eScZTnkXxyYKV9xgCBbFntkEaK90hsEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vbqsh7ea7joooyh"
Content-Disposition: inline
In-Reply-To: <CAGudoHHuG-SCgv+F23eScZTnkXxyYKV9xgCBbFntkEaK90hsEQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13836-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 781F111D754
X-Rspamd-Action: no action


--3vbqsh7ea7joooyh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
MIME-Version: 1.0

On Tue, Feb 10, 2026 at 12:19:27PM +0100, Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> This is going to depend on the scale you test on. I was testing on
> south of 32. But I also got a miniscule win from removing css set lock
> as the problem for me, instead everything shifted to tasklist.

To be on the same page -- that means you have nr_cpus >=3D 32?

> Per my other e-mail tasklist lock retains the terrible 3-times locking
> and it is doing rather expensive work while holding it. It is
> plausible it happens to be at the top at that scale, but that's only
> an argument for fixing it. Even if you don't see the css thing at the
> top at the moment, it will be there once someone(tm) sorts out the
> tasklist problem.

I did a quick test (with 6.18.8-1.g886f4c4-default), first `perf top`
while will-it-scale was running:

  74.23%  [kernel]                        [k] native_queued_spin_lock_slowp=
ath
   6.91%  [kernel]                        [k] intel_idle_irq
   0.87%  [kernel]                        [k] update_sd_lb_stats.constprop.0
   0.68%  [kernel]                        [k] _raw_spin_lock
   0.63%  [kernel]                        [k] clear_page_erms
   0.56%  [kernel]                        [k] sched_balance_find_dst_group
   0.40%  [kernel]                        [k] alloc_vmap_area

and then bpftrace for the waiters:
  $ bpftrace -e 'kprobe:native_queued_spin_lock_slowpath {@[arg0]=3Dcount()=
;}
                 END {for($kv : @) {printf("%s\t%d\n", ksym($kv.0), (int64)=
$kv.1);} clear(@); }'\
                 >bpftrace.out
  $ sort -k2 -r -n bpftrace.out | head | column -t
  pidmap_lock         10482583
  nft_pcpu_tun_ctx    3693517
  css_set_lock        1511164
  input_pool          976252
  tasklist_lock       798578
  nft_pcpu_tun_ctx    481962
  0xffff8abc3ffd55b0  95371
  0xffff8a6d3ffd65b0  93686
  0xffff8a5e218f0840  29501
  0xffff8a5e451dca40  29421

or measured by cummulative waiting time:
  $ bpftrace -e 'kprobe:native_queued_spin_lock_slowpath {@[cpu]=3Darg0; @s=
t[cpu]=3Dnsecs;}
                 kretprobe:native_queued_spin_lock_slowpath /@[cpu]/ {$lat=
=3Dnsecs-@st[cpu]; @lats[@[cpu]]=3Dsum($lat);}
                 END {for($kv : @lats) {printf("%s\t%d\n", ksym($kv.0), (in=
t64)$kv.1);} clear(@lats); clear(@st); clear(@) }'\
                 >bpftrace2.out
 =20
  $ sort -k2 -r -n bpftrace2.out | head -n15 | column -t
  pidmap_lock         1931209805
  rcu_state           1823286316
  rcu_state           1581455156
  rcu_state           1328804835
  rcu_state           1299517157
  rcu_state           1134101627
  nft_pcpu_tun_ctx    1027837665
  0xffff8abc3ffd55b0  861441978
  0xffff8a6d3ffd65b0  850732998
  css_set_lock        520009479
  input_pool          316598763
  tasklist_lock       127161061
  0xffff8aac40023200  32380418
  0xffff8a5e002ab600  30194951
  rcu_state           18334578

Hm, it's interesting that is suggestive of why I saw no big change with
css_set_lock in my setup.


Michal

--3vbqsh7ea7joooyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYti4RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiFQAD/dujVCBXt2f88GMZZB2kR
pQYl3BltlPFQXTMw+AXyaJgBALzetW1WReClSi/zBf+gbJfr4j29exYhf8jHqd4j
d/8E
=ueHw
-----END PGP SIGNATURE-----

--3vbqsh7ea7joooyh--

