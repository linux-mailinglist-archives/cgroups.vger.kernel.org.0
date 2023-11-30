Return-Path: <cgroups+bounces-705-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DFE7FF42B
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 16:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D11C20D37
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33653811;
	Thu, 30 Nov 2023 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108AFD7F;
	Thu, 30 Nov 2023 07:57:44 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E3EF1FCF5;
	Thu, 30 Nov 2023 15:57:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42C4213AB1;
	Thu, 30 Nov 2023 15:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /unbCvawaGWqagAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 30 Nov 2023 15:57:42 +0000
Date: Thu, 30 Nov 2023 16:57:41 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <ZWiw9cEsDap1Qm5h@tiehlicka>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130153658.527556-1-schatzberg.dan@gmail.com>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out2.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 BAYES_HAM(-0.00)[31.54%];
	 RCVD_COUNT_THREE(0.00)[3];
	 MID_RHS_NOT_FQDN(0.50)[];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,google.com,vivo.com,vger.kernel.org,kvack.org,linux-foundation.org,redhat.com,infradead.org,intel.com,huawei.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 7E3EF1FCF5
X-Spam: Yes

On Thu 30-11-23 07:36:53, Dan Schatzberg wrote:
[...]
> In contrast, I argue in favor of a swappiness setting not as a way to implement
> custom reclaim algorithms but rather to bias the balance of anon vs file due to
> differences of proactive vs reactive reclaim. In this context, swappiness is the
> existing interface for controlling this balance and this patch simply allows for
> it to be configured differently for proactive vs reactive reclaim.

I do agree that swappiness is a better interface than explicit anon/file
but the problem with swappiness is that it is more of a hint for the reclaim
rather than a real control. Just look at get_scan_count and its history.
Not only its range has been extended also the extent when it is actually
used has been changing all the time and I think it is not a stretch to
assume that trend to continue.

Now if we extend the user interface to trigger the reclaim do we expect
that we always do SCAN_EQUAL if a user specifies swappiness or are we OK
that the implementation is free to ignore that "hint"?
-- 
Michal Hocko
SUSE Labs

