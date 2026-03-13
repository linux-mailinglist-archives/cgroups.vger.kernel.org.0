Return-Path: <cgroups+bounces-14804-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJv8Jsv3s2nYdgAAu9opvQ
	(envelope-from <cgroups+bounces-14804-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:40:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E9A2825B7
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EFC03033E79
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639F2BEFF5;
	Fri, 13 Mar 2026 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="ZfR9LyYV"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145B38656F
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402057; cv=none; b=I+tOcOMv/Yoa25vxtgyxrHb7QolG1TOW/HcVnrtjDmEQeYvlZUOoiZFCZM0MFSFEX9AFhLuCwA7RlpI9VlYLdPgEf6+B5RYXnvT/4hgVb0GiDg8ioOHV4AiVrlSGhm/ea/GOffC0aQapYZLmRYWMRlWnBP19O3oysDnpDURDfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402057; c=relaxed/simple;
	bh=nQ4uMhVjcviJYXNUdkyAvGOeW4Twif2aN+oYCcIk5vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFx+PsN3JJbRY3L2+B1jsEQJVYSpyVyHB/bVBnpUdRTTR0jM+kpVxRBSTR+WILGoblvJZEv3XRxXsSIIM3ILu1tesns5x3yJRuuzwMM0L9ECjA1Whx7rlg7c3UqnvDyPDHv8L6zH7twkNuF3or5DTVza8xuW5KpRsv8XYX45zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=ZfR9LyYV; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773402042; x=1774006842; i=natalie.vock@gmx.de;
	bh=2sAXta4SvmT7kNBqZYYSXy+Hl6aNqxAgonVNmONzzhI=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZfR9LyYVGyfPaQTe3C3v2VbyeO8XAquUIqzEBMG1Q57fZRAP1nZQDQxQxN3lsCb1
	 X9Yy7beWs/aN+Ee9G6PPUzlHqYE0aAuMjsh+kwuGsaeA/qpPhQNmgl0f3DV/DvFHC
	 tD6klJR8ooAZ4E9difTsqxyBGwhVy0vjJjgEaH5/SfGVkrovhIbHGRRRVq87NEspj
	 2scABLvUJI5eOsxXNNfRSAEC7VDs4S3ghvb+WtLDga/DfqL9KyEJLzo57Izy7Xnyh
	 usTRoegK25bkAiAlDNIc4T73pcx8DGBjBL6zPEIEeAtQptL7e06Yh96I0V57mKtxm
	 XoETwuGgjT13JSDFTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1vuegQ2xkl-00CDPN; Fri, 13
 Mar 2026 12:40:41 +0100
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 13 Mar 2026 12:40:03 +0100
Subject: [PATCH v6 4/6] drm/ttm: Split cgroup charge and resource
 allocation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260313-dmemcg-aggressive-protect-v6-4-7c71cc1492db@gmx.de>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Natalie Vock <natalie.vock@gmx.de>
X-Mailer: b4 0.14.3
X-Provags-ID: V03:K1:UW9y6l93WuE6PHEktworfefOqbZjUG/nvLE7eeJRzrjr5XUg+0X
 Oz5jXWA/wupU7v9cqlJIN8S1xmXPtYYEuv5d/hH+lutBOBR6CjY9Q+km6naH0DUIdK31Oks
 xgkz30VDiDFMuhvDOflgbUgRQVsKMUm2Y1y5uMMkq3cSb+qk3Bo/OeyKXvI4ynECQSXsZxY
 weEdwzoINVU0kDfQmwBmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OSbVI/s+BQM=;4F0XmMwBYrtYgSt/zOLKnMAhvKU
 mKK+3Xic+SC6niChZygxkfKObeFgm4Loqcr02/sPk9uZBZhFnv1SGZamccJStKzByMRQvqOPS
 BfT6u5EtxrWtQuZpimlh2jqVbFZ26V0hPh1rJsEijGUJ9EgyFk7t4hx8kghygP1eiuN0RR2cl
 W7cuhr0X48P36QVkpQfLdV9V/OavSVjrcd4A2Yy7CIL3LvQxuWT48TNPHVXh7/+Ir3+ljwyB1
 xYQbe2wDpp1F8qHRXBytsHx3w9yyYWxAE97IscceL01jEdluV3W6FGydWbFnuqsYnjmDl6nxd
 XV98snGOxqmKR48mNWZnfPjIFBMWluC5plvim5xzKeLOtVRbPrm/9EU0jtu8OlRphLpSxqjHK
 r8dsM3pggnZ1m87l8ZSaG6Sr7KwoiwELXLktgMeF4SBevt7o5LzdZsxsYVF3/ori9UHM/+A5q
 AuTtvLjE5Id/PZH+42U2lR0RkXFF3/Uc3091wnXTz/Ivij+m+xfh6/9OjpLOKOBSf0loNvdiK
 +9ia1NMQqpKmwsyHN9RwdLedX+HtUymzJXidK0sFadLxu3TlWZiyWVs0GAYEwKlEEjkaI0rFj
 jO6bohlCsCrhK9caSkO0fG7TimE4D5O1YcADgg/RJiDadmLOInniPdfithv+DFrtpCX8aJuKi
 OALM9GIFJnWo3Mzp54n/QVtkASGGG/yTv7lSqVyhgs4TagzVh77D4K3Mdq+3y163mUgCEcTVV
 PmcNW+rx8XI8vJfwPjwjoOM9b3urXUET5kc2dpntEDlF8bXdmeoqeKP7SSmGW8HXD9U7S3XbY
 kVAjWIY5NuJVBe56mglbGHvEBVP4EDNzInpcUH9lvhuJtpr5TmPvQuSSYz27W821mpIm6ECWB
 XNBR0hhNZ9haa4CAiJeTveGilsTpfNvXeKTCiYoi1x2/yMy9qIEvHsgBGcc9estZJ7DrB+q/X
 WP73f6B3DKdjJGDQKeTvmkeymdOQYkb2BzFR7pYM+7GHLkj2D71QzQ+qoy62guqRNCs5pwB6t
 2FRGh1RLXXN9WsaMjBwa6fdaW0W7z9+xUdwyWHUqbxsmJtYhqTIH0llXIEzXqug/4Fx00znQX
 uEmBlmaMJ/sJDaxXVRtjCQdZ9U4RRqO2GHb/XICHH1aVhd9mMouAV32HhctIIryiO2zqYnFag
 t2GYMny5/etmT4KqzA7HF/zzgKBmNlHbFvjvgVIi7/MLk5K4Y5XUVUwc179+xXr+JBjpzyDOr
 XjuYu6E91j2tivUbd0YBiL1mWWX4thXL1AsWeyXsLkcDsS5B/MvvKIzBL+eKRn6J8jwpr8YUB
 HTFTuWc4ZxqiDCm1kyBcLvFVE4PuQ/WRW4SfAy/w8PIM3atuqfP+e1+LFI51MYANBgITwGjRc
 a2bw6GIImqSbKOOswPUyYvkSlpnhBUHGyo/QFpg4iq4/tK/RRFPqcmGyKoL3JRAy06XfN8tdG
 pnmwkB5fczrFxmLxRhN1WNHfaiO1Go793iN0wrvaqAf3ADiIQ5NpBHzG9SIQ5IBi1bOTrTXvW
 V6VuvLWx5c9khoRHm9nHHs9ENP+ilGrFJDl5h1CNjXGFihMNDrtMDtE5ltiuk4Kv+8eM4Ogbu
 3YaFoitYIlZZxhey4xFcQg6K+T4Fcl/mOdLS9E2VoRAhfgefp6kQTiU3JS72qMxIJElNq7sR/
 38XvaVaNMm2k3cw9/gKminyMYyAJOXIEJf6iXf6LpWgTc3BjM/xF+SxEPu+u8/9zDeDxEbcDc
 qSDQ0qy3SizA/stTxCFA1Fv7mUUtjk1thyOW7mHBuys9yJB99LQ4gM054ajE5y/DQ7G1+cJjj
 Ojdf1LNp5sdBvc6u1xOO7DYn9ru2S6vYwe68+E/0X8VGTEc8Ljxgt5YsfJxZKvlmnUKi+GZ+I
 Nbn8Orph6iutrQaxULG86IK7w6ikMNSy7jlNJi5gKjh87Wsh+/5Qr8pjNZalA/1E2LvSmBMHz
 5CbZSpUg2EdQR8sRPTT2E+ag15AgoE5C+3ol3n6ps4RnaDkEPAwpjm2aQMlCoN229w65hWLSW
 0VVaGTnQEQWLJjpanxBf5troBxo4RMHSnwc4aicFbrHvswKAnE8Jgw0+MhxNUoOBTan/8GuU1
 kHhvvzT6KkfrM5PDSapNPySqY5tFqKqZQOwyInzBKDrhnIbdgim6lZPRVT25eklb/rQGQ2wfw
 f7FEPCt3v0VTpkkE5P8z9703o+xp9qNG5iVbHl3nB01k7zjsgWJSzby7XKTLq87DF5r08NpnN
 kYXYn4RiSKraLQikJD7Q2S9aSBBJGxaOAnamhNB8b7DVgwFXhZ51mDhgKsCKEIEYpyXpzxNia
 oyQaTY6rD2QmJKol8Zz+XDT0q7QD+nJ1cMsfl0e2W24NETqWXgL7addeckM9k9BrKdVRx5uk7
 zn51dFgXLDEPesILIULmnbBhZpvIffjtNQAJiLg28VwTDlFQSmOE0LDkTjTj/7rD6YHHcrdqi
 fjWVKKntaq3kjBpOQuY7wNch4YIUChL5ThXQKFDUIt5nAOEkzEhrtOA+nNgdSz6MgIgbDiWVj
 6PyfeCqIrbk+Ebuwgy90GSS71Se/LLFZzdhDo60xzvRglEaE2PwVP08ErWXYX1+dxovOrS8CC
 gx3Hjk1j+k/c5dXjz4e88TMC3VWvepEnRyidjiJJld6+J4txb3idHXBhp1JkGjMXt4o+3UsJs
 9bF83fe/+cxPxGbMe6WvdpoJ9aeOkuIM8+nPXV+zYBjWsjNWOy04C/fVifgGN9t51MQ5AkIsd
 JPntNXGn7MOwJiCyIgnuGfeu9pUwuaDfCi210XxpfnXS5WU2ZurqskyEiPfli0eqYtLytK5IZ
 0/OpZM1lLm/vR1RH2+r4HEQM6kuARJgNbftLER9h1DlK/KiV2DdiMWeeLBoBFgbG5b81WLfxn
 SgBNuFDyJqnGcxf0wM8VgJyfUA54DKY9+K4WHUYisQIL7tHhAZl5AUWjH1j8Mat+rLZ/f+dOq
 eE0B1sRxlF/MdNIAI62RYLimK3BRyxZ2jf4vjQTobupXtW2dh5iH7FRXF4kKEVtCgDxi7vblJ
 BrBSen8TMCsrwhsEFIdLW0iDI60KoOvNgVHbizE1Q/Hj6kmVwdBo27XrinKJa2BYAAW5z20VN
 u1FJG3y196+IP0KiKdNJx4hsi2nSyGwJsrPPzMv+/iUJqgqdCAYZS9Pkbz2NLPOihqTTeCfVP
 S99nOMcvqaihA9rq6XSY9Qf9XQFdzWEwHgbJVfamGkhI3M8+msfo+kj84mYywUFmYPyBPwxpS
 F7uHfBSNR+uVpfXTKyMpJCTsIJArpHaFCNoQ56W4seRef2CLiu4OLd6mv2CNiB1Bfc56HVIDH
 WbS8QEf8sqyFHlMC6d2BO0vD93C8GSMaVmW7BGUhpIN6l5Bgvbv8Qa97PHJidc6pIBWkJqain
 lz3JjkkyJtQnUMD8FO3+8IRayW6u1fUwSJ+7B6f5cho0DSsyCThkxiWOUcIJXi5Kda4GKPQC7
 CRnP3xzn79piy5vJZudmbwgIqM1syEAnrZ15fxswUV1Faeco0dotoqhTROa2v03BQS+SKS/ZQ
 UDkeckKRw5pYLm0hUuP7mlWi/7Cohh4qO7+TG81m6lRxmwvAttIdz3TZQg7aGTv+lXuFpp1Sz
 1t3iCypwOEdisBOIV5JIzBnqM2RlrU671o7SrBpKxvAXWXg9kSNz8UzHmoC9uWDsNQk22jAxW
 /4bVKC0Yoyfv76jF902AR6R6M3w9DvKneATLvgVL0WOUQEwCQFI6ovqCV3Us7l/2rdJKml9VU
 26KZTKF3GR+kZV3S4mbcAuXy1DR5X8PiWK2oeRqtCLSPvqyrPos9BIYB4QExYaRP/xOrbwvhS
 LoxErdg/Ugki1cTzWX5imAXldtItkmaN7Dhsh8Vhxq6eMCOk1svz6Gbgxx3gKP+00CT/trv0P
 dFD0rhs9et38k9EkYU0AT9jU6otgj0BmTgapKImI+vOm4dbw5LHb0Ns+zdsBJzyYqvab1vKu7
 BqeQ+8ZARyHkWIh1VTxVeyK5LVrj8jIqomLnWqOMoCsIPRYs/OTI5aE8opXlIlcNfJLId+Q41
 4woDKW8WM78H8G4gSnThk52AZ4CyTGehGXflM3qoVLz0fVT6y+iz74e/3O8QXwTi9mc1CwVbo
 J1EDiFdM0Vt2m6u2JIO/ESx3YckigdQh2MUBgBN3L1S3UbPZlfNKF9cl8g1vqr00F7lHb4dNW
 97dgTx73ao6Ji7QWAR7ugmMt8JeBfX00aiwRohIwtyJ1ahXvItQYvQC1CCqhXc0jWu/RSPQfx
 dbwjLOi53DKW8d2aFQm/sYFPdo99TBy+PcjMrtYfqazHM9YUrwm/WfekqvDi+K5FRGsctPK7E
 dqnvSMP/Mi9VJV/n1V771QDZfiIB5ldcYXw91lIzC55T7zEZTwYnhY8XgN+0slPelPutBPNEq
 GeIiOwKrP5S8rQoItZhlC5MWumICXV9lYq45icHjs+lIH5YAVTv2cFuXcR/7CgdrpnWP1HGMN
 hwetfB65SH/dkviS62C3rGaqczVizHU/A7s52akqCdUeb/mCmYAYvAMI7PBEnkjVndnVZdheP
 C0PorQtQmSUlcDNrGOhnkg+XR1OnF+L3h9akQQomi5wc3fFaT1KOyqcw1IsuAF3qIz9qGs8dj
 jpbMwCe/tRkVKeBQKK8AjysC9UtdCCQUNe1OUi78Wk/4YdMfAEVuUlytSMMwVJAWIzhodfz3+
 I8pW6/VoGrplllkG3FuMlLjdpyehJgxXSk1AvDnSJZESKakqO9Bc6yixjhTs4kxvnbxcTFsxV
 f+MTOxjYqoZVutU+L/2DOYaySdZ+0hOkg73sNdd/isn2LJwIhwJaaiTrILGGEOkSLrJx1xSnX
 CaIPw5M7nmHkplaiQ/XXl6e6aSyulvTmRm5v9xgy6UVTDbRXOS9pVAZy1c6spMPZSKcFMclRN
 fYuH2Q9QmTCnufm9Y5xuZl9b8hoK1L/o1skYOuyFXmqwknPj7TyozDQnmJd58I3NS1Bluw3sd
 i2soFA3xlNDiU/YWyRpiQ2zSXXrTXAzAJkfUEpxmRaVL364HpYpNauJO9zefQt4VNsHCWua0R
 DQltQD25dZSthxkuf1Ny/yw2Gw4tJhipBxM4V7qu/NyBxxXYnQ0mfGWykURF0uEKGmlFRzBM3
 AfEJwCTj73LoKkKZ4Xa52Bu9u0tWrGcXh42bh4SoD7rwyUWWB1WPyO+PKQ6Ye118O6sLoTKbn
 wGoe+X8DPdAgq+J+B20j7OtMBqBtTKfmOBCusBCt2jNqmPVb8k102YdZtynYnZWkcef31tJDp
 bo+HXvK7u3Vw7d8z2hF9Xal/T/tR9cPmMIE2gqZmDQ==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14804-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Queue-Id: 53E9A2825B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Coupling resource allocation and cgroup charging is racy when charging
succeeds, but subsequent resource allocation fails. Certain eviction
decisions are made on the basis of whether the allocating cgroup is
protected, i.e. within its min/low limits, but with the charge being
tied to resource allocation (and uncharged when the resource allocation
fails), this check is done at a point where the allocation is not actually
charged to the cgroup.

This is subtly wrong if the allocation were to cause the cgroup to exceed
the min/low protection, but it's even more wrong if the same cgroup tries
allocating multiple buffers concurrently: In this case, the min/low
protection may pass for all allocation attempts when the real min/low
protection covers only some, or potentially none of the allocated
buffers.

Instead, charge the allocation to the cgroup once and keep the charge
for as long as we try to allocate a ttm_resource, and only undo the charge
if allocating the resource is ultimately unsuccessful and we move on to
a different ttm_place.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/ttm/ttm_bo.c       | 66 ++++++++++++++++++++++++++-------=
=2D----
 drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++--------
 include/drm/ttm/ttm_resource.h     |  6 +++-
 3 files changed, 85 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 5cca0d6edbaf6..4adc9b80cba4a 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -490,8 +490,12 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struc=
t ttm_resource_manager *man
 }
=20
 struct ttm_bo_alloc_state {
+	/** @charge_pool: The memory pool the resource is charged to */
+	struct dmem_cgroup_pool_state *charge_pool;
 	/** @limit_pool: Which pool limit we should test against */
 	struct dmem_cgroup_pool_state *limit_pool;
+	/** @in_evict: Whether we are currently evicting buffers */
+	bool in_evict;
 };
=20
 /**
@@ -520,28 +524,39 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_o=
bject *bo,
 	bool may_evict;
 	int ret;
=20
-	may_evict =3D force_space && place->mem_type !=3D TTM_PL_SYSTEM;
-
-	ret =3D ttm_resource_alloc(bo, place, res,
-				 force_space ? &alloc_state->limit_pool : NULL);
+	may_evict =3D !alloc_state->in_evict && force_space &&
+		    place->mem_type !=3D TTM_PL_SYSTEM;
+	if (!alloc_state->charge_pool) {
+		ret =3D ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
+					      force_space ? &alloc_state->limit_pool
+							  : NULL);
+		if (ret) {
+			/*
+			 * -EAGAIN means the charge failed, which we treat
+			 * like an allocation failure. Therefore, return an
+			 * error code indicating the allocation failed -
+			 * either -EBUSY if the allocation should be
+			 * retried with eviction, or -ENOSPC if there should
+			 * be no second attempt.
+			 */
+			if (ret =3D=3D -EAGAIN)
+				ret =3D may_evict ? -EBUSY : -ENOSPC;
+			return ret;
+		}
+	}
=20
+	ret =3D ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
 	if (ret) {
-		/*
-		 * -EAGAIN means the charge failed, which we treat like an
-		 * allocation failure. Therefore, return an error code indicating
-		 * the allocation failed - either -EBUSY if the allocation should
-		 * be retried with eviction, or -ENOSPC if there should be no second
-		 * attempt.
-		 */
-		if (ret =3D=3D -EAGAIN)
-			return may_evict ? -EBUSY : -ENOSPC;
-
 		if (ret =3D=3D -ENOSPC && may_evict)
-			return -EBUSY;
-
+			ret =3D -EBUSY;
 		return ret;
 	}
=20
+	/*
+	 * Ownership of charge_pool has been transferred to the TTM resource,
+	 * don't make the caller think we still hold a reference to it.
+	 */
+	alloc_state->charge_pool =3D NULL;
 	return 0;
 }
=20
@@ -596,8 +611,9 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, =
struct ttm_buffer_object *
=20
 	evict_walk->evicted++;
 	if (evict_walk->res)
-		lret =3D ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
-					  evict_walk->res, NULL);
+		lret =3D ttm_bo_alloc_at_place(evict_walk->evictor, evict_walk->place,
+					     walk->arg.ctx, false, evict_walk->res,
+					     evict_walk->alloc_state);
 	if (lret =3D=3D 0)
 		return 1;
 out:
@@ -636,6 +652,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	};
 	s64 lret;
=20
+	state->in_evict =3D true;
+
 	evict_walk.walk.arg.trylock_only =3D true;
 	lret =3D ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
=20
@@ -666,6 +684,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 		goto retry;
 	}
 out:
+	state->in_evict =3D false;
 	if (lret < 0)
 		return lret;
 	if (lret =3D=3D 0)
@@ -798,6 +817,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_obj=
ect *bo,
 				res, &alloc_state);
=20
 		if (ret =3D=3D -ENOSPC) {
+			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
 			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
 			continue;
 		} else if (ret =3D=3D -EBUSY) {
@@ -806,11 +826,15 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_o=
bject *bo,
=20
 			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
=20
-			if (ret =3D=3D -EBUSY)
-				continue;
-			else if (ret)
+			if (ret) {
+				dmem_cgroup_uncharge(alloc_state.charge_pool,
+						bo->base.size);
+				if (ret =3D=3D -EBUSY)
+					continue;
 				return ret;
+			}
 		} else if (ret) {
+			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
 			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
 			return ret;
 		}
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_=
resource.c
index 192fca24f37e4..a8a836f6e376a 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -373,30 +373,52 @@ void ttm_resource_fini(struct ttm_resource_manager *=
man,
 }
 EXPORT_SYMBOL(ttm_resource_fini);
=20
+/**
+ * ttm_resource_try_charge - charge a resource manager's cgroup pool
+ * @bo: buffer for which an allocation should be charged
+ * @place: where the allocation is attempted to be placed
+ * @ret_pool: on charge success, the pool that was charged
+ * @ret_limit_pool: on charge failure, the pool responsible for the failu=
re
+ *
+ * Should be used to charge cgroups before attempting resource allocation=
.
+ * When charging succeeds, the value of ret_pool should be passed to
+ * ttm_resource_alloc.
+ *
+ * Returns: 0 on charge success, negative errno on failure.
+ */
+int ttm_resource_try_charge(struct ttm_buffer_object *bo,
+			    const struct ttm_place *place,
+			    struct dmem_cgroup_pool_state **ret_pool,
+			    struct dmem_cgroup_pool_state **ret_limit_pool)
+{
+	struct ttm_resource_manager *man =3D
+		ttm_manager_type(bo->bdev, place->mem_type);
+
+	if (!man->cg) {
+		*ret_pool =3D NULL;
+		if (ret_limit_pool)
+			*ret_limit_pool =3D NULL;
+		return 0;
+	}
+
+	return dmem_cgroup_try_charge(man->cg, bo->base.size, ret_pool,
+				      ret_limit_pool);
+}
+
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res_ptr,
-		       struct dmem_cgroup_pool_state **ret_limit_pool)
+		       struct dmem_cgroup_pool_state *charge_pool)
 {
 	struct ttm_resource_manager *man =3D
 		ttm_manager_type(bo->bdev, place->mem_type);
-	struct dmem_cgroup_pool_state *pool =3D NULL;
 	int ret;
=20
-	if (man->cg) {
-		ret =3D dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit=
_pool);
-		if (ret)
-			return ret;
-	}
-
 	ret =3D man->func->alloc(man, bo, place, res_ptr);
-	if (ret) {
-		if (pool)
-			dmem_cgroup_uncharge(pool, bo->base.size);
+	if (ret)
 		return ret;
-	}
=20
-	(*res_ptr)->css =3D pool;
+	(*res_ptr)->css =3D charge_pool;
=20
 	spin_lock(&bo->bdev->lru_lock);
 	ttm_resource_add_bulk_move(*res_ptr, bo);
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource=
.h
index 33e80f30b8b82..549b5b796884d 100644
=2D-- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -456,10 +456,14 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
 void ttm_resource_fini(struct ttm_resource_manager *man,
 		       struct ttm_resource *res);
=20
+int ttm_resource_try_charge(struct ttm_buffer_object *bo,
+			    const struct ttm_place *place,
+			    struct dmem_cgroup_pool_state **ret_pool,
+			    struct dmem_cgroup_pool_state **ret_limit_pool);
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res,
-		       struct dmem_cgroup_pool_state **ret_limit_pool);
+		       struct dmem_cgroup_pool_state *charge_pool);
 void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource =
**res);
 bool ttm_resource_intersects(struct ttm_device *bdev,
 			     struct ttm_resource *res,

=2D-=20
2.53.0


