Return-Path: <cgroups+bounces-898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0638090EC
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 20:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416A31F213DC
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6014D5B7;
	Thu,  7 Dec 2023 19:00:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A8E10C8;
	Thu,  7 Dec 2023 11:00:11 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A49B21DBB;
	Thu,  7 Dec 2023 19:00:09 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 090C613907;
	Thu,  7 Dec 2023 19:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 78qvATkWcmU7eQAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Thu, 07 Dec 2023 19:00:09 +0000
Date: Thu, 7 Dec 2023 20:00:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
Message-ID: <dhhjw4h22q4ngwtxmhuyifv32zjd6z2relrcjgnxsw6zys3mod@o6dh5dy53ae3>
References: <20231206162900.1571025-1-schatzberg.dan@gmail.com>
 <20231206162900.1571025-2-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3hzrc2h7is5f6ec"
Content-Disposition: inline
In-Reply-To: <20231206162900.1571025-2-schatzberg.dan@gmail.com>
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 BAYES_HAM(-0.01)[48.19%];
	 RCVD_COUNT_THREE(0.00)[3];
	 MID_RHS_NOT_FQDN(0.50)[];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[21];
	 SIGNED_PGP(-2.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,google.com,vivo.com,vger.kernel.org,kvack.org,kernel.org,bytedance.com,lwn.net,linux-foundation.org,redhat.com,infradead.org,huawei.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out1.suse.de: domain of mkoutny@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=mkoutny@suse.com
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 2A49B21DBB
X-Spam-Score: 15.00
X-Spam: Yes


--k3hzrc2h7is5f6ec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2023 at 08:28:56AM -0800, Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> @@ -6902,12 +6913,33 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
...
> +	int swappiness = -1;

Here you use a negative number...

> @@ -136,6 +136,9 @@ struct scan_control {
...
> +	/* Swappiness value for reclaim, if NULL use memcg/global value */
> +	int *swappiness;

... and here a NULL to denote the unset value.

I'd suggest unifying those. Perhaps the negative to avoid unnecessary dereferences.

Thanks,
Michal

--k3hzrc2h7is5f6ec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZXIWNQAKCRAGvrMr/1gc
jsi/AP4ryoDOY4++Kh04OMP3Cy10vHIZmku9PA7uoVwjJ+hVmwEA5f9bJ5wivkdn
FZExa4N388uEYUDV6aoyBsryEujrogs=
=A0Xu
-----END PGP SIGNATURE-----

--k3hzrc2h7is5f6ec--

