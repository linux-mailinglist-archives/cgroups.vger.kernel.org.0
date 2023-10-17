Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB97CC4A6
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjJQNVF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbjJQNUy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 09:20:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025AC102;
        Tue, 17 Oct 2023 06:20:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EC111FF1A;
        Tue, 17 Oct 2023 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697548850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8rIgsiyeow9bSYTBQDVxfOSeh5WLhqfq9xKpFGrsQk=;
        b=c/NGDKU9m02qXpPSjU/ohhYKapnmN9YA25RciLnaSbcFp/ZkkvEqDRp3JswU9Ph7COiMhe
        /nSAd/saagxIB2K+o3JjTdSvIyA7yFUUHVGNGY2/2EORw+cn0mb+zGitBefR5JZARPdQ33
        HZF8lBgWu19Tzp0T0Gzzc1+bK/qpuBs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F7B413584;
        Tue, 17 Oct 2023 13:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BFbmBDGKLmX6cAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 17 Oct 2023 13:20:49 +0000
Date:   Tue, 17 Oct 2023 15:20:47 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the
 cgroup root_list RCU safe
Message-ID: <q7yaokzrcg5effyr2j7n6f6ljlez755uunlzfzpjgktfmrvhnb@t44uxkbj7k5k>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4ps3f24q6yvqo7s"
Content-Disposition: inline
In-Reply-To: <20231017124546.24608-2-laoar.shao@gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.01
X-Spamd-Result: default: False [-7.01 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-2.81)[99.20%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[19];
         SIGNED_PGP(-2.00)[];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,bytedance.com,cmpxchg.org,vger.kernel.org]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--b4ps3f24q6yvqo7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 12:45:38PM +0000, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> Therefore, making it RCU-safe would be beneficial.

Notice that whole cgroup_destroy_root() is actually an RCU callback (via
css_free_rwork_fn()). So the list traversal under RCU should alreay be
OK wrt its stability. Do you see a loophole in this argument?


>  /* iterate across the hierarchies */
>  #define for_each_root(root)						\
> -	list_for_each_entry((root), &cgroup_roots, root_list)
> +	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
> +				!lockdep_is_held(&cgroup_mutex))

The extra condition should be constant false (regardless of
cgroup_mutex). IOW, RCU read lock is always required.

> @@ -1386,13 +1386,15 @@ static inline struct cgroup *__cset_cgroup_from_r=
oot(struct css_set *cset,
>  		}
>  	}
> =20
> -	BUG_ON(!res_cgroup);
> +	WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
>  	return res_cgroup;

Hm, this would benefit from a comment why !res_cgroup is conditionally
acceptable.

>  }
> =20
>  /*
>   * look up cgroup associated with current task's cgroup namespace on the
> - * specified hierarchy
> + * specified hierarchy. Umount synchronization is ensured via VFS layer,
> + * so we don't have to hold cgroup_mutex to prevent the root from being
> + * destroyed.

I tried the similar via explicit lockdep invocation (in a thread I
linked to you previously) and VFS folks weren't ethusiastic about it.

You cannot hide this synchronization assumption in a mere comment.

Thanks,
Michal

--b4ps3f24q6yvqo7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZS6KLQAKCRAGvrMr/1gc
jtMQAQD4OOSCYc0rd0v6OeR+aZZPoijWIDf8E9FIaLGpXK0JlgD9GmUhhH9bgOsm
n5U/VJuqqPdTKYQxgtnA+yU9SbomkAA=
=a8F0
-----END PGP SIGNATURE-----

--b4ps3f24q6yvqo7s--
