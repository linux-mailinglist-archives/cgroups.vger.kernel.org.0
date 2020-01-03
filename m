Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2458712F645
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2020 10:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgACJs6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jan 2020 04:48:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:57340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACJs6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 3 Jan 2020 04:48:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 062F2AE87;
        Fri,  3 Jan 2020 09:48:55 +0000 (UTC)
Date:   Fri, 3 Jan 2020 10:48:54 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     teawater <teawaterz@linux.alibaba.com>
Cc:     Chris Down <chris@chrisdown.name>, Hui Zhu <teawater@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
Message-ID: <20200103094853.GM22847@blackbody.suse.cz>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
 <20191225140546.GA311630@chrisdown.name>
 <6E9887B9-EEF7-406E-90D4-3FAEFE0A505E@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline
In-Reply-To: <6E9887B9-EEF7-406E-90D4-3FAEFE0A505E@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 26, 2019 at 02:56:40PM +0800, teawater <teawaterz@linux.alibaba.com> wrote:
> For example, an application does a lot of file access work in a
> memory-constrained environment.
> [...]
> Both of them are extreme examples.
The examples are quite generic. Do cgroup v2 controls really prevent
handling such workloads appropriately?

Besides that, note that per-cgroup swappiness as used in v1 cannot be
simply transferred into v2 because, it's a concept that doesn't take
into account cgroup hierarchies (how would parent's swappiness affect
children? what would swappiness on inner nodes mean?).

HTH,
Michal

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl4PDgAACgkQia1+riC5
qSgXQQ//fdhyA8EegA3X3Xot5ZkyaIG2xgwbk8ZiiOuhPr2xEmrpBrEf3eC+IBPH
/4Iq/kuHKAZEJcOtfJZepJoF9LDQjoAdpqVd21ohGgxxXsCTFnT/et+Z8t/dpaXB
gpp6VahkMZxdJ0vBCPhHu46nkpBACbjMzCklzpAaVa1Rz95L8Ob4Eel1e76R7S6n
KxLyLxkgdRVV8GeABMS7wf5NljfqAQ/SUCKfjoJYyC58PA3LVsYYke7bXSlMwLay
jt1Pb635+2ajdT3LahtR2r9xGFxpL+Rf2WPbJ3MPUl7MQ4HwV0zw4fpqSKtXBeRJ
x7oTfUNZfOGXR2Nnm8Tdb2rumnznwhtuFAn3wvwxKOIiT9iS0Ye21KvMQ3hqyeIB
ZVDYMT0eUmxpjbZgwMcH9UpCpwT4HyKDLFH57mleTIrBeRjCua6tf4nf4S+RHSc7
VxyH4VEkQgD6M9z/ySQDfRMKU/SBy6UQkxCQ4avrx4igbQL+MENQ/6ntD0Kp4XFJ
suj2i9UdOmGzBt5kkJMkGjFN/NuOF/WEf1ZCr3/Sg6g5RzJna/Oh0dEKhhsb8/vp
0ENgmveAUNbtijTby+6xo+6UBoE9HEcnNMu++evdBZRzvXcbnwhVZr84Qyjg15Mq
T7S51fMo9A+I+lC0KFOud0hSUTaaPPesnIGs6v2jqlbh/8rKids=
=QzSj
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
