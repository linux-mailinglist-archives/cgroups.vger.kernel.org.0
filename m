Return-Path: <cgroups+bounces-897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38578090DB
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 19:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB3F1C209FF
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946D4B12D;
	Thu,  7 Dec 2023 18:57:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8CC1718;
	Thu,  7 Dec 2023 10:57:43 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5A321FB9C;
	Thu,  7 Dec 2023 18:57:41 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 878AB13907;
	Thu,  7 Dec 2023 18:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OahgIKUVcmWGeAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Thu, 07 Dec 2023 18:57:41 +0000
Date: Thu, 7 Dec 2023 19:57:40 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <2wknjgwapqcwienztskcmra7ez6f3gd3tf3v5kr3eifc3oefca@i7iohdywggls>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
 <ZWmoTa7MlD7h9FYm@tiehlicka>
 <20231201170955.GA694615@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mnaliqucreqrrc5q"
Content-Disposition: inline
In-Reply-To: <20231201170955.GA694615@cmpxchg.org>
X-Spam-Score: 15.00
X-Spam-Flag: YES
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 SPAM_FLAG(5.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 RCVD_COUNT_THREE(0.00)[3];
	 MID_RHS_NOT_FQDN(0.50)[];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 FREEMAIL_CC(0.00)[suse.com,gmail.com,linux.dev,google.com,vivo.com,vger.kernel.org,kvack.org,linux-foundation.org,redhat.com,infradead.org,intel.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out2.suse.de: domain of mkoutny@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=mkoutny@suse.com
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: A5A321FB9C
X-Spam-Score: 15.00
X-Spam: Yes


--mnaliqucreqrrc5q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 12:09:55PM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> Well I'm the person who wrote the initial cgroup2 memory interface,
> and I left it out because there was no clear usecase for why you'd
> want to tweak it on a per-container basis.

There is also the issue of the default value and its relation to the
global vm.swappiness. Which disappeared with v2.
The "stateless" passing of per-reclaim swappiness looks cleaner in this
way.

0.02=E2=82=AC,
Michal

--mnaliqucreqrrc5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZXIVogAKCRAGvrMr/1gc
jlf1AP0dzSbUAofDvmRUC31Er7u/1nBrohiLQNnNK4hUBdZvvAD+P2KPRr389H0z
c4GMGid6/YqCc8MJT1uJMTgiWP7sjwQ=
=LzXI
-----END PGP SIGNATURE-----

--mnaliqucreqrrc5q--

