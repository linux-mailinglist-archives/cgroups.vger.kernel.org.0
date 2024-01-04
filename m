Return-Path: <cgroups+bounces-1073-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D559C8241EB
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 13:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BBA2874B8
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 12:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB421A09;
	Thu,  4 Jan 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XhYFJs26";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XhYFJs26"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728642137E;
	Thu,  4 Jan 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43552220AB;
	Thu,  4 Jan 2024 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704371923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4uvQkYHYu1QazRbslMypDkupBVwWahN8iFalOSYDpT4=;
	b=XhYFJs26rRAOJl7Zn6+UGJtoGHtlajogsGKFwi/XTOrabn1JfBZAgXhU+yRMGgS7cQnuA7
	ay+cV55cOpbbrbcxbdn/WM8q/0X+lhPEl8qRbTTzK4T90OLSSx748Vy8x+tHsrGlwDypr7
	LhFZ8uZjFlo4UaDJpcwNuMmnTfVtWwo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704371923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4uvQkYHYu1QazRbslMypDkupBVwWahN8iFalOSYDpT4=;
	b=XhYFJs26rRAOJl7Zn6+UGJtoGHtlajogsGKFwi/XTOrabn1JfBZAgXhU+yRMGgS7cQnuA7
	ay+cV55cOpbbrbcxbdn/WM8q/0X+lhPEl8qRbTTzK4T90OLSSx748Vy8x+tHsrGlwDypr7
	LhFZ8uZjFlo4UaDJpcwNuMmnTfVtWwo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD97137E8;
	Thu,  4 Jan 2024 12:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gmCwMdKmlmWaHQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 04 Jan 2024 12:38:42 +0000
Date: Thu, 4 Jan 2024 13:38:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tj@kernel.org" <tj@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>, 
	"mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"Zhang, Bo" <zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>, 
	"anakrish@microsoft.com" <anakrish@microsoft.com>, 
	"sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, 
	"yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Message-ID: <mmcdj5ulscoxyofetdgmygytd2dnjusnoj3ypix2plnwp7nbks@bqesmrpmsca7>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
 <op.2f523elowjvjmi@hhuan26-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6xoj57vgctb6e4ry"
Content-Disposition: inline
In-Reply-To: <op.2f523elowjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.91 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,intel.com:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[10.53%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XhYFJs26
X-Spam-Score: -1.91
X-Rspamd-Queue-Id: 43552220AB


--6xoj57vgctb6e4ry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Dec 18, 2023 at 03:24:40PM -0600, Haitao Huang <haitao.huang@linux.=
intel.com> wrote:
> Thanks for raising this. Actually my understanding the above discussion w=
as
> mainly about not doing reclaiming by killing enclaves, i.e., I assumed
> "reclaiming" within that context only meant for that particular kind.
>=20
> As Mikko pointed out, without reclaiming per-cgroup, the max limit of each
> cgroup needs to accommodate the peak usage of enclaves within that cgroup.
> That may be inconvenient for practical usage and limits could be forced to
> be set larger than necessary to run enclaves performantly. For example, we
> can observe following undesired consequences comparing a system with curr=
ent
> kernel loaded with enclaves whose total peak usage is greater than the EPC
> capacity.
>=20
> 1) If a user wants to load the same exact enclaves but in separate cgroup=
s,
> then the sum of cgroup limits must be higher than the capacity and the
> system will end up doing the same old global reclaiming as it is currently
> doing. Cgroup is not useful at all for isolating EPC consumptions.

That is the use of limits to prevent a runaway cgroup smothering the
system. Overcommited values in such a config are fine because the more
simultaneous runaways, the less likely.
The peak consumption is on the fair expense of others (some efficiency)
and the limit contains the runaway (hence the isolation).

> 2) To isolate impact of usage of each cgroup on other cgroups and yet sti=
ll
> being able to load each enclave, the user basically has to carefully plan=
 to
> ensure the sum of cgroup max limits, i.e., the sum of peak usage of
> enclaves, is not reaching over the capacity. That means no over-commiting
> allowed and the same system may not be able to load as many enclaves as w=
ith
> current kernel.

Another "config layout" of limits is to achieve partitioning (sum =3D=3D
capacity). That is perfect isolation but it naturally goes against
efficient utilization. The way other controllers approach this trade-off
is with weights (cpu, io) or protections (memory). I'm afraid misc
controller is not ready for this.

My opinion is to start with the simple limits (first patches) and think
of prioritization/guarantee mechanism based on real cases.

HTH,
Michal

--6xoj57vgctb6e4ry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZZamzwAKCRAGvrMr/1gc
jh5HAQC7JKavOsXc5+CL5ZJfrJhI3she9MQsyt/LmjPqO9lFcwEAq8+16AXaKO23
JWl2/b7BSmoBdumcmAz8DkzUXD7GIg0=
=kG33
-----END PGP SIGNATURE-----

--6xoj57vgctb6e4ry--

