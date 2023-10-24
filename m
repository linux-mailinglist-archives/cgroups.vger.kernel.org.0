Return-Path: <cgroups+bounces-10-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C527D4834
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 09:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79F81C20B5C
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85A14277;
	Tue, 24 Oct 2023 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FX7fo0zW"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3F12B92
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 07:15:28 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974710E3
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 00:15:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54041e33845so3152925a12.3
        for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698131721; x=1698736521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4XKdmsnPQl3dHhgnXly1nlogFG+nLP27ca7G/hp5Wc=;
        b=FX7fo0zW89JxzUSsdFEkd2IEJuJ2Xo17Z6GACP/dG1XOzb+bt/yIuGaaLkTYZvg3NF
         ro0+8FLLeJqIKIgfhrN55ZTirbjcZEibtaEsr4bwfaEkB7YsS5oNIG6Jp2mVRHpcJdEH
         rlpdE/iiT18VU4FKBHH98TyTKgcspm59t1R67mjYUTa5Nc1PVGD57gA9Ja0tyztW1vnX
         zbJmF8IOVD1p3EqZPu1LkhbeRzUsPy7OMD9yxSzhog1wKeYVkv9Ne8PpVaIxjkV23kQc
         sxz6BZONgfeVHPwaKGG44lxTy/OA1JzwVvFPgrgqA+ncDoAl5gxlo0OdQgTVEiSEZcXJ
         dPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131721; x=1698736521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4XKdmsnPQl3dHhgnXly1nlogFG+nLP27ca7G/hp5Wc=;
        b=WumshbsmR2tBfxJ9TFrmI6+65+nMJWkO8W0LpvSpigB5pdtaiohtMpzJy4pbn6SZ+s
         WAmYDGkUo/rDNceiLdCl3/Ar9Lh/JXrFIkD9WCm/QQBDeM7Sc5mFzCiALkiFdwSvTGuf
         kO2Zwqd8wtSV+dR2CwATkTCYNXATY9VLE2GE/Uarhk9FbrKajNLK+RjJGl9aGfxbxZ1j
         WrysVsbXiO7QCUB2QquWtWTKFER12djHD7TLUK+DVikggxawqmxwNxm6quTVJ6IEUT9v
         NvPiwh6sDd3x1CWEDwWDxAmRL/nDUpgHsrtaw4Q0IketmUv6swQ7DpG2gKM9d2by8Zxt
         QH1g==
X-Gm-Message-State: AOJu0YzibwXw/EYrvoinDRaqLr1E9FT14j8uEqhlMlXH6G49Y3FnJVs6
	TX2CWH/DkjtLCtLB9iVu87+MSxznHaOXqrmubaSDUg==
X-Google-Smtp-Source: AGHT+IHeCDSmlx/q4j4BChR9UnNp99IWrBQlgv+NK948E/DuFKXsYw2qlrWTat2PzFNNjs06XC9lNfRLyYZNIKakjpk=
X-Received: by 2002:a17:907:7f8f:b0:9be:2469:bdf5 with SMTP id
 qk15-20020a1709077f8f00b009be2469bdf5mr11438912ejc.15.1698131720868; Tue, 24
 Oct 2023 00:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com> <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
 <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
 <ZTXLeAAI1chMamkU@feng-clx> <CAJD7tka5UnHBz=eX1LtynAjJ+O_oredMKBBL3kFNfG7PHjuMCw@mail.gmail.com>
 <CAJD7tkYXJ3vcGvteNH98tB_C7OTo718XSxL=mFsUa7kO8vzFzA@mail.gmail.com> <ZTdqpcDFVHhFwWMc@xsang-OptiPlex-9020>
In-Reply-To: <ZTdqpcDFVHhFwWMc@xsang-OptiPlex-9020>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Oct 2023 00:14:42 -0700
Message-ID: <CAJD7tka7hmOD6KPmJBJa+TscbYEMmTjS+Jh2utPfTbKkfvwD9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To: Oliver Sang <oliver.sang@intel.com>
Cc: Feng Tang <feng.tang@intel.com>, Shakeel Butt <shakeelb@google.com>, 
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"Huang, Ying" <ying.huang@intel.com>, "Yin, Fengwei" <fengwei.yin@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, 
	"kernel-team@cloudflare.com" <kernel-team@cloudflare.com>, Wei Xu <weixugc@google.com>, 
	Greg Thelen <gthelen@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000212ee0608711aa1"

--0000000000000212ee0608711aa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 11:56=E2=80=AFPM Oliver Sang <oliver.sang@intel.com=
> wrote:
>
> hi, Yosry Ahmed,
>
> On Mon, Oct 23, 2023 at 07:13:50PM -0700, Yosry Ahmed wrote:
>
> ...
>
> >
> > I still could not run the benchmark, but I used a version of
> > fallocate1.c that does 1 million iterations. I ran 100 in parallel.
> > This showed ~13% regression with the patch, so not the same as the
> > will-it-scale version, but it could be an indicator.
> >
> > With that, I did not see any improvement with the fixlet above or
> > ___cacheline_aligned_in_smp. So you can scratch that.
> >
> > I did, however, see some improvement with reducing the indirection
> > layers by moving stats_updates directly into struct mem_cgroup. The
> > regression in my manual testing went down to 9%. Still not great, but
> > I am wondering how this reflects on the benchmark. If you're able to
> > test it that would be great, the diff is below. Meanwhile I am still
> > looking for other improvements that can be made.
>
> we applied previous patch-set as below:
>
> c5f50d8b23c79 (linux-review/Yosry-Ahmed/mm-memcg-change-flush_next_time-t=
o-flush_last_time/20231010-112257) mm: memcg: restore subtree stats flushin=
g
> ac8a48ba9e1ca mm: workingset: move the stats flush into workingset_test_r=
ecent()
> 51d74c18a9c61 mm: memcg: make stats flushing threshold per-memcg
> 130617edc1cd1 mm: memcg: move vmstats structs definition above flushing c=
ode
> 26d0ee342efc6 mm: memcg: change flush_next_time to flush_last_time
> 25478183883e6 Merge branch 'mm-nonmm-unstable' into mm-everything   <----=
 the base our tool picked for the patch set
>
> I tried to apply below patch to either 51d74c18a9c61 or c5f50d8b23c79,
> but failed. could you guide how to apply this patch?
> Thanks
>

Thanks for looking into this. I rebased the diff on top of
c5f50d8b23c79. Please find it attached.

--0000000000000212ee0608711aa1
Content-Type: application/octet-stream; 
	name="0001-memcg-move-stats_updates-to-struct-mem_cgroup.patch"
Content-Disposition: attachment; 
	filename="0001-memcg-move-stats_updates-to-struct-mem_cgroup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lo3zpp7k0>
X-Attachment-Id: f_lo3zpp7k0

RnJvbSAwYjBkZmZkZmUxOTIzODJhM2FhY2ZhMzEzYmVlZTY4YjMzYmY3ZDg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPgpE
YXRlOiBUdWUsIDI0IE9jdCAyMDIzIDA3OjAyOjAyICswMDAwClN1YmplY3Q6IFtQQVRDSF0gbWVt
Y2c6IG1vdmUgc3RhdHNfdXBkYXRlcyB0byBzdHJ1Y3QgbWVtX2Nncm91cAoKLS0tCiBpbmNsdWRl
L2xpbnV4L21lbWNvbnRyb2wuaCB8ICA0ICsrKysKIG1tL21lbWNvbnRyb2wuYyAgICAgICAgICAg
IHwgMzMgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvbWVtY29udHJvbC5oIGIvaW5jbHVkZS9saW51eC9tZW1jb250cm9sLmgKaW5kZXggZjY0
YWMxNDAwODNlZS4uYjRkZmNkOGI5Y2MxYyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tZW1j
b250cm9sLmgKKysrIGIvaW5jbHVkZS9saW51eC9tZW1jb250cm9sLmgKQEAgLTI3MCw2ICsyNzAs
OSBAQCBzdHJ1Y3QgbWVtX2Nncm91cCB7CiAKIAlDQUNIRUxJTkVfUEFERElORyhfcGFkMV8pOwog
CisJLyogU3RhdHMgdXBkYXRlcyBzaW5jZSB0aGUgbGFzdCBmbHVzaCAqLworCWF0b21pYzY0X3QJ
CXN0YXRzX3VwZGF0ZXM7CisKIAkvKiBtZW1vcnkuc3RhdCAqLwogCXN0cnVjdCBtZW1jZ192bXN0
YXRzCSp2bXN0YXRzOwogCkBAIC0zMDksNiArMzEyLDcgQEAgc3RydWN0IG1lbV9jZ3JvdXAgewog
CWF0b21pY190CQltb3ZpbmdfYWNjb3VudDsKIAlzdHJ1Y3QgdGFza19zdHJ1Y3QJKm1vdmVfbG9j
a190YXNrOwogCisJdW5zaWduZWQgaW50IF9fcGVyY3B1ICpzdGF0c191cGRhdGVzX3BlcmNwdTsK
IAlzdHJ1Y3QgbWVtY2dfdm1zdGF0c19wZXJjcHUgX19wZXJjcHUgKnZtc3RhdHNfcGVyY3B1Owog
CiAjaWZkZWYgQ09ORklHX0NHUk9VUF9XUklURUJBQ0sKZGlmZiAtLWdpdCBhL21tL21lbWNvbnRy
b2wuYyBiL21tL21lbWNvbnRyb2wuYwppbmRleCAxODJiNGYyMTVmYzY0Li5lNWQyZjNkNGQ4NzQ3
IDEwMDY0NAotLS0gYS9tbS9tZW1jb250cm9sLmMKKysrIGIvbW0vbWVtY29udHJvbC5jCkBAIC02
MjcsOSArNjI3LDYgQEAgc3RydWN0IG1lbWNnX3Ztc3RhdHNfcGVyY3B1IHsKIAkvKiBDZ3JvdXAx
OiB0aHJlc2hvbGQgbm90aWZpY2F0aW9ucyAmIHNvZnRsaW1pdCB0cmVlIHVwZGF0ZXMgKi8KIAl1
bnNpZ25lZCBsb25nCQlucl9wYWdlX2V2ZW50czsKIAl1bnNpZ25lZCBsb25nCQl0YXJnZXRzW01F
TV9DR1JPVVBfTlRBUkdFVFNdOwotCi0JLyogU3RhdHMgdXBkYXRlcyBzaW5jZSB0aGUgbGFzdCBm
bHVzaCAqLwotCXVuc2lnbmVkIGludAkJc3RhdHNfdXBkYXRlczsKIH07CiAKIHN0cnVjdCBtZW1j
Z192bXN0YXRzIHsKQEAgLTY0NCw5ICs2NDEsNiBAQCBzdHJ1Y3QgbWVtY2dfdm1zdGF0cyB7CiAJ
LyogUGVuZGluZyBjaGlsZCBjb3VudHMgZHVyaW5nIHRyZWUgcHJvcGFnYXRpb24gKi8KIAlsb25n
CQkJc3RhdGVfcGVuZGluZ1tNRU1DR19OUl9TVEFUXTsKIAl1bnNpZ25lZCBsb25nCQlldmVudHNf
cGVuZGluZ1tOUl9NRU1DR19FVkVOVFNdOwotCi0JLyogU3RhdHMgdXBkYXRlcyBzaW5jZSB0aGUg
bGFzdCBmbHVzaCAqLwotCWF0b21pYzY0X3QJCXN0YXRzX3VwZGF0ZXM7CiB9OwogCiAvKgpAQCAt
Njk1LDE0ICs2ODksMTQgQEAgc3RhdGljIHZvaWQgbWVtY2dfc3RhdHNfdW5sb2NrKHZvaWQpCiAK
IHN0YXRpYyBib29sIG1lbWNnX3Nob3VsZF9mbHVzaF9zdGF0cyhzdHJ1Y3QgbWVtX2Nncm91cCAq
bWVtY2cpCiB7Ci0JcmV0dXJuIGF0b21pYzY0X3JlYWQoJm1lbWNnLT52bXN0YXRzLT5zdGF0c191
cGRhdGVzKSA+CisJcmV0dXJuIGF0b21pYzY0X3JlYWQoJm1lbWNnLT5zdGF0c191cGRhdGVzKSA+
CiAJCU1FTUNHX0NIQVJHRV9CQVRDSCAqIG51bV9vbmxpbmVfY3B1cygpOwogfQogCiBzdGF0aWMg
aW5saW5lIHZvaWQgbWVtY2dfcnN0YXRfdXBkYXRlZChzdHJ1Y3QgbWVtX2Nncm91cCAqbWVtY2cs
IGludCB2YWwpCiB7CiAJaW50IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKLQl1bnNpZ25lZCBp
bnQgeDsKKwl1bnNpZ25lZCBpbnQgKnN0YXRzX3VwZGF0ZXNfcGVyY3B1OwogCiAJaWYgKCF2YWwp
CiAJCXJldHVybjsKQEAgLTcxMCwxMCArNzA0LDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtZW1j
Z19yc3RhdF91cGRhdGVkKHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZywgaW50IHZhbCkKIAljZ3Jv
dXBfcnN0YXRfdXBkYXRlZChtZW1jZy0+Y3NzLmNncm91cCwgY3B1KTsKIAogCWZvciAoOyBtZW1j
ZzsgbWVtY2cgPSBwYXJlbnRfbWVtX2Nncm91cChtZW1jZykpIHsKLQkJeCA9IF9fdGhpc19jcHVf
YWRkX3JldHVybihtZW1jZy0+dm1zdGF0c19wZXJjcHUtPnN0YXRzX3VwZGF0ZXMsCi0JCQkJCSAg
YWJzKHZhbCkpOworCQlzdGF0c191cGRhdGVzX3BlcmNwdSA9IHRoaXNfY3B1X3B0cihtZW1jZy0+
c3RhdHNfdXBkYXRlc19wZXJjcHUpOwogCi0JCWlmICh4IDwgTUVNQ0dfQ0hBUkdFX0JBVENIKQor
CQkqc3RhdHNfdXBkYXRlc19wZXJjcHUgKz0gYWJzKHZhbCk7CisJCWlmICgqc3RhdHNfdXBkYXRl
c19wZXJjcHUgPCBNRU1DR19DSEFSR0VfQkFUQ0gpCiAJCQljb250aW51ZTsKIAogCQkvKgpAQCAt
NzIxLDggKzcxNSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtZW1jZ19yc3RhdF91cGRhdGVkKHN0
cnVjdCBtZW1fY2dyb3VwICptZW1jZywgaW50IHZhbCkKIAkJICogcmVkdW5kYW50LiBBdm9pZCB0
aGUgb3ZlcmhlYWQgb2YgdGhlIGF0b21pYyB1cGRhdGUuCiAJCSAqLwogCQlpZiAoIW1lbWNnX3No
b3VsZF9mbHVzaF9zdGF0cyhtZW1jZykpCi0JCQlhdG9taWM2NF9hZGQoeCwgJm1lbWNnLT52bXN0
YXRzLT5zdGF0c191cGRhdGVzKTsKLQkJX190aGlzX2NwdV93cml0ZShtZW1jZy0+dm1zdGF0c19w
ZXJjcHUtPnN0YXRzX3VwZGF0ZXMsIDApOworCQkJYXRvbWljNjRfYWRkKCpzdGF0c191cGRhdGVz
X3BlcmNwdSwgJm1lbWNnLT5zdGF0c191cGRhdGVzKTsKKwkJKnN0YXRzX3VwZGF0ZXNfcGVyY3B1
ID0gMDsKIAl9CiB9CiAKQEAgLTU0NjcsNiArNTQ2MSw3IEBAIHN0YXRpYyB2b2lkIF9fbWVtX2Nn
cm91cF9mcmVlKHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZykKIAkJZnJlZV9tZW1fY2dyb3VwX3Bl
cl9ub2RlX2luZm8obWVtY2csIG5vZGUpOwogCWtmcmVlKG1lbWNnLT52bXN0YXRzKTsKIAlmcmVl
X3BlcmNwdShtZW1jZy0+dm1zdGF0c19wZXJjcHUpOworCWZyZWVfcGVyY3B1KG1lbWNnLT5zdGF0
c191cGRhdGVzX3BlcmNwdSk7CiAJa2ZyZWUobWVtY2cpOwogfQogCkBAIC01NTA0LDYgKzU0OTks
MTEgQEAgc3RhdGljIHN0cnVjdCBtZW1fY2dyb3VwICptZW1fY2dyb3VwX2FsbG9jKHZvaWQpCiAJ
aWYgKCFtZW1jZy0+dm1zdGF0c19wZXJjcHUpCiAJCWdvdG8gZmFpbDsKIAorCW1lbWNnLT5zdGF0
c191cGRhdGVzX3BlcmNwdSA9IGFsbG9jX3BlcmNwdV9nZnAodW5zaWduZWQgaW50LAorCQkJCQkJ
ICAgICAgIEdGUF9LRVJORUxfQUNDT1VOVCk7CisJaWYgKCFtZW1jZy0+c3RhdHNfdXBkYXRlc19w
ZXJjcHUpCisJCWdvdG8gZmFpbDsKKwogCWZvcl9lYWNoX25vZGUobm9kZSkKIAkJaWYgKGFsbG9j
X21lbV9jZ3JvdXBfcGVyX25vZGVfaW5mbyhtZW1jZywgbm9kZSkpCiAJCQlnb3RvIGZhaWw7CkBA
IC01NzM1LDEwICs1NzM1LDEyIEBAIHN0YXRpYyB2b2lkIG1lbV9jZ3JvdXBfY3NzX3JzdGF0X2Zs
dXNoKHN0cnVjdCBjZ3JvdXBfc3Vic3lzX3N0YXRlICpjc3MsIGludCBjcHUpCiAJc3RydWN0IG1l
bV9jZ3JvdXAgKm1lbWNnID0gbWVtX2Nncm91cF9mcm9tX2Nzcyhjc3MpOwogCXN0cnVjdCBtZW1f
Y2dyb3VwICpwYXJlbnQgPSBwYXJlbnRfbWVtX2Nncm91cChtZW1jZyk7CiAJc3RydWN0IG1lbWNn
X3Ztc3RhdHNfcGVyY3B1ICpzdGF0YzsKKwlpbnQgKnN0YXRzX3VwZGF0ZXNfcGVyY3B1OwogCWxv
bmcgZGVsdGEsIGRlbHRhX2NwdSwgdjsKIAlpbnQgaSwgbmlkOwogCiAJc3RhdGMgPSBwZXJfY3B1
X3B0cihtZW1jZy0+dm1zdGF0c19wZXJjcHUsIGNwdSk7CisJc3RhdHNfdXBkYXRlc19wZXJjcHUg
PSBwZXJfY3B1X3B0cihtZW1jZy0+c3RhdHNfdXBkYXRlc19wZXJjcHUsIGNwdSk7CiAKIAlmb3Ig
KGkgPSAwOyBpIDwgTUVNQ0dfTlJfU1RBVDsgaSsrKSB7CiAJCS8qCkBAIC01ODI2LDkgKzU4Mjgs
MTAgQEAgc3RhdGljIHZvaWQgbWVtX2Nncm91cF9jc3NfcnN0YXRfZmx1c2goc3RydWN0IGNncm91
cF9zdWJzeXNfc3RhdGUgKmNzcywgaW50IGNwdSkKIAkJCX0KIAkJfQogCX0KKwkqc3RhdHNfdXBk
YXRlc19wZXJjcHUgPSAwOwogCS8qIFdlIGFyZSBpbiBhIHBlci1jcHUgbG9vcCBoZXJlLCBvbmx5
IGRvIHRoZSBhdG9taWMgd3JpdGUgb25jZSAqLwotCWlmIChhdG9taWM2NF9yZWFkKCZtZW1jZy0+
dm1zdGF0cy0+c3RhdHNfdXBkYXRlcykpCi0JCWF0b21pYzY0X3NldCgmbWVtY2ctPnZtc3RhdHMt
PnN0YXRzX3VwZGF0ZXMsIDApOworCWlmIChhdG9taWM2NF9yZWFkKCZtZW1jZy0+c3RhdHNfdXBk
YXRlcykpCisJCWF0b21pYzY0X3NldCgmbWVtY2ctPnN0YXRzX3VwZGF0ZXMsIDApOwogfQogCiAj
aWZkZWYgQ09ORklHX01NVQotLSAKMi40Mi4wLjc1OC5nYWVkMDM2OGUwZS1nb29nCgo=
--0000000000000212ee0608711aa1--

