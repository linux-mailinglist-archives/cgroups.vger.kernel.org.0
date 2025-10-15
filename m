Return-Path: <cgroups+bounces-10777-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A3BDEE07
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 15:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F26403488
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993723E32B;
	Wed, 15 Oct 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="B8oVOYoO"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A09231A41
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536676; cv=none; b=H5H9JZqlXQFgjW/+MXcHsktBSt1dPqrgDKvbzcBPAfjHsCbGSFINoh6l0QNmpYvEtm9VfVH65CRdZnQhNtaT/u3THfFAz4um/6uHEtZPu4jHAjFO5XnKwfDehJWHwEyDWyJVcqL8HQlPLvGSZKBMus/C/c+jzRB42jMorYcMkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536676; c=relaxed/simple;
	bh=0Jyvx1C/ODO+qiNn7BSK38zV3vah3PsSIZxLBexFDeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YceRl0R9ZBqSjlD4Ie5dGI+/G7lZnczK9l7b5/JA9fRQEAxzNsjcWMFuJj8p/2OHML9EwiCLGkT6n2CNISlEdrTDTWZj+WxKqTFW+54t+KUPIerteXXhm8f3WVUjf0fIJ4ttBA2FmbET8L9O3QBstVhtVo6t9qlld257TeRMtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=B8oVOYoO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760536671; x=1761141471; i=natalie.vock@gmx.de;
	bh=8ee9aeFGO7Ecar5112J8Y7NqevKLfXwHmxfmTmH+umE=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B8oVOYoOi9hvS6tjpPQ+tOB+cNHM3mRvFgH/KFk5jDgp6D5W3D+oU1XTS9/j0cbL
	 64APlhgCrhP588b6bxxtx66MDBprkvffH2HM1YlOjC2mNes/qi9+EdbX/8zkLIXXo
	 mqVrSsMdFBqQ4NbSzbRrLhRYkW/AqHISWlcjid+vx+eIUOgET/Z6Z0YdHBNgvqNrZ
	 lOpSGFkHMyIzSEe1YZ8f+GhQ0ryBhUT0ica7FK18pAwiiLf7FWErYqayBeopJCmK4
	 NTHp6R75NIMJbBrt0KurQJ6kimwz69GmawWVAdyv7WTeRWuhJPMqujNB2vyPPIaUw
	 vq2ggtGA3s5qM3NWRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.3] ([109.91.201.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1uPDg122Vi-00nqMS; Wed, 15
 Oct 2025 15:57:51 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Date: Wed, 15 Oct 2025 15:57:28 +0200
Subject: [PATCH v2 1/5] cgroup/dmem: Add queries for protection values
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20251015-dmemcg-aggressive-protect-v2-1-36644fb4e37f@gmx.de>
References: <20251015-dmemcg-aggressive-protect-v2-0-36644fb4e37f@gmx.de>
In-Reply-To: <20251015-dmemcg-aggressive-protect-v2-0-36644fb4e37f@gmx.de>
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Provags-ID: V03:K1:aHKk0CaAbbQIwBRXw+cNuUaWCKK7YJ1AJ9ekJlEvdsXFxu5wotI
 HHnPou6A6D2OC5WRm79Z2/jVUm4TlIZvQ8SQoOAkEUGARsfHpuC1hMqnqlwghpLfMUXhitY
 /7cUles02jmfIqwIs+Rrb3F5zsW3bfzSpAk5Ndo1iRu1y+lJpNGLyMDPaSCmeNwcnm9neaw
 QY1CF8W68/V9fNFDLzmGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YmHJsU+pI7M=;X70WspH1SaUhIARjGJhYSIozvaQ
 CxgEMKbVfFw7OBGqG3Gp422BFzg5l58ngqlHqho8a34vlmwWCaZ3/KhJ1N0oTB3wHoNa5aJ+h
 GlgB9YcqXdmRMrkQTDSA1qXx7B0/uz0WB8p8gyw0jPT3tQs5keb05DqfcTXEOUmF7yrmRpyrK
 Dxdct3N8cQ22vsWvAOWTL5wLVDsibTQmq36aVjCdCUHtW4qsC8BTO4sAKs8kFi60HbVTOEFCB
 uco2Bpb4RuyNx7At7N866SG6o9uAge5kOkwgT5rMVOrISBZDbA+oluQ+QJOtik03o+o3DPKo9
 oHVdB8waK1rg9SIXCDhSqXhunmYdiZh3xOWjU/zZzCOH6TScieKImrFjKG3pFFfyD0+xndbmy
 ks8l5YKLDkSf550yK4LL+1OHUD7fGyx9NSTzA0uQTytKRhU5wdlcZH5mA/+8CjRAyFJmkn0eI
 dc2dqW3rVbUSGT8M7W/E/hFLKX3x6wwH0k52gUHMUGDDP0LAftxY/vkGq198UEWdaJIezHP9L
 RVcZtHfKlqeBLuIr/DLdvc9Al4+0uScty2Itf8sOL/dXYeIYHGf1az01gLoCRr5h8KPpw/1Zp
 zBjOy3Ti2jWRVeTlgjJLh8NB/CL71cuzu2nhDgHHcSId4c+Phu/HVoNGjxOOHBvQ/IyzZg5fo
 w/4HSNQrRH9VraxvbdzBQuPXk9ad+lugnq4HYXZ5yd0lHz9qYptL1vOQZIBFA/DBexJUQKgFx
 ynoTi9iFLnfP3DMfpJoe9+xschBuNxg7HL5iZLQ3d8wskB/4SmvGIYD2k3TXCcARQUoFyyAOv
 aYB8cNGqES+3z7bXwXRBn2+c+3XQ4hLOJLWJQxVl0AScidsXoR8JCAJKFx47IIDToRQ84owMk
 WLZZG8YJdkWaTxQzO0zrCQjCByawfHw7CTg0oWLp4jnxXtOXJ1LUCZUrdg3sChRPYRLqS0W4F
 rgmHOtt7ByiuG5f5OAp1mt9uGKu0ZE3JzT5ZkzqBjhOeTcXhyskZF16CeneeHobLqtrX+k8sX
 8qDd0Za/BKK52RI/O21enstYSM0P9lpIoTLYEe7tKl89KrxjmK8RGZ6dgrxWb+XFUqjnnxYT7
 XJBaoXB87fXERogIqZZOA5AFnMyfVCTY/hhdUXbyZ+rLU5fMAFdhFWI6k+bLFG2B9Anaw1ygJ
 8uuzqDsKYFdfio7VquCAOg/FuJzpkYJrvjaiXeQoHc5woKhHJnesJa5HMg8Ec/JWh5Whc2RrO
 5939cDhNJWtZLpDYLF15ateir521KnnKudC+3EAuAcPBqleuhLXJJV2neigv9VPXu2hwEtSSQ
 mLippVs0HhoMrGQUxEx5A5STE5vCRSz5lXnfMW+PXppNDorh2YDLbUjSluFQVr9rK9qIfSyz8
 LJPJupb9Ib5JGG5hMKODed0a32QlS+KmsbgTznpnQyNG+QNKP/0MEhTQDcfIjQxgvbRzl46yJ
 C7JwpMuaOMnI9ut+Ll3Je1gfYseQ7uUpdlueCNgHoBcb1sEkOLnVc5SQoKrWeNrgR7sv54nGG
 ll29oq3eUFfXm0rcuWW/AZYFz9erYIGz4yxtXznfB9A+SyW77AB9WXW9PmqD4q6p7lX9P97yt
 PexpCzLavczUoh8jvRGjbx5oLMThYzFYwSZI+F4pSF0KS7V8w2n1YvFmCvcFb8uvlkU9t6eaB
 xHUuKTQLtYCRhz9YfLLarhjUac/gSywD+B/0gsVjfcRhyQSrACirzFHBO4N4S0ZzAfiaskz9J
 3VAftVcuzAmhgWEJarNdkuXioDcYgS2k/IMkeVuSlfaeqkNHykwbuawzaIHOYzc8aIYbhboyQ
 /itel7q0nmfGKtcfcLiuNbXaVA+nz1aloq8CtUqDkYcPEAmE4TrxOm6n69HuO8HmcS/Jf6f2x
 /Jf//jNjQ9+lm5LXEmi3UBNLusNJcC9mEDuryzNBNtygmHQkQeI0Yjv3tLjDrP3ceRZAqEShw
 dg7VABN6hlliKICoQiq7kwcbmeJo6DZMj3J7YIDhC+5aNHNOgkbSkwy8iK3O74xOhEebBVmcQ
 KJc1Jb6H/FiZ+A6QCrAU7qAJPxjqHcETEk+KvLHOxIAGujIKEVR6yLE6unZGDuGEuVYN2TaE9
 0GlnUQX/p34rm2Ok4wD4LBKERTyEWC1hXu4FdiIpCPrC+HTHBq8bdgI3+y8npP+Ro0Oy5I5cn
 NonhenAPFk3XoYxOJU3NCYTbrlCebO3MMGrD5JJF4zhoR9/mQKWm8G/Qwv9VNygnDnMdcwhDU
 3TlMUJfVOYz5myHHiYaDiLvC8m9DcMS8txdyqvAXwNhYzE+uqgvTJXJoOgNa8GHSNlUYolCGn
 ahfCTpOxa4kV054dZW//9Yenp/WeViepoZQn0BVb+cmJRr9+3feMtZSikcGQjR5MqzTkZycQX
 WPHoVAoUkkeddBAlyaVM3ulk9nch9bALI7D0OvUaVJjQkDNa480Bc9JRbh0xmwYEYHSJn2Tyt
 BOnDL/hCyFjOKTJqa2ebG/z47YUofPm9YTfhJ5WQy0JwBSZjjQKjoQlYbn2hZ8wAmfFCzAPUP
 i/R3iax4jHXFmEw/TnCv/pKZIuLgNXO4InjoNlCYFfCst3GSj6NZ0l+FpHWm7tMP9X9BjvQhZ
 EuD89WoEiz7klxCqx/4rsaJETECcPV8CNzZ5/VJM8khLgOFd3gDWFdOj2e7kDSOyEhYswVnnU
 GVg9uKpgLJgLPtwnf7Ko3IpdyQjV+XR6RBF/3f98tbuil+zhVFLjTrKi3kQntgTtu++X2N4kd
 yjmCkvnmjOwp1L9d7r57NocJH0q23BuXdHCNP0I6p3Jirdw2SSHDwQLokNT+iyk9sq85gmmsX
 OBNgr55+NmTnE7B8IRwlFMm1sHRQpYf+66U49BFViBrmxbzBKQXWcMC9q+oiq+zT1zLpB3UZ6
 mDuWN6v09sPU860f/x5hjK0wwXckDBgCy7q9TzLlV+KwvUhhUZDt45QzGblMc8mkz92oxL1bR
 NeHCXZzF+zXikqypJgMcQQfOdX/aEq3LYKQ0LXBn86+h2SerxNcAFou/cQZy3QHiSDrpunBqG
 DzEhmr36sLBdGFAf1dh6NWFWgTqsb+LuIqWDsqdM64ULLj8xR1RUBe6dh0WDsg+PmNDuBPLIb
 2mA8PbM8JO7NDUWBAxsc6Xy3+0Kge9NQZGJvosPU4iTbtyyhrBppAiRuXMQhEAB3aMmEt+/Qr
 QGao0+627zjWV4UmbBB+cVoYFxC5n7bcJSiKDas2T/7b3edB1yDEutL4o5Wmm83TG5MtYNo5C
 bsfvKeTC+0SvYFmyRzjijIn92sbeYCj859qMZji1/Y+u4o07bLaPBv+/ByFtLx9Gab+LiRadm
 1KlkwQ/lN02GfGK/neITl/TgWEEcKLwYXUVZPC0fkgIah6N4c/7NqogXIx68h4FMaV1mgpYIq
 lC09r2mXX474/zUC0jjHiYA5lBe6EFOOhO1NfHuDWuSsrLtDNVfdehc/nK6Ams730/4koelgv
 Cpab08M396t7dvUXgTmR/mctNZfLlHqMsCiXg1K67+HGPVcHGrE9p7zqSXPLsO5sikXC/Y+7j
 RSjfX/BYFooVBgcP3+8ALl/qM4QatJZx4LBYgyLmYuQX+ndrYskV4JzBRmkAf+dBbc4iRzCgV
 JvEnte/gA+mielObBdjLeD5Aqok9uXnWTIRdAZ7Ek+T//bJerm/XjEpOCstOFfRjQ9M65R2uZ
 nEzKaYnrAhNX2XF6+x5XJgZLHQN4jKq2p7OnmXnXTbX/LaHTrpZHojeNDQP3j2WpnKgGtpYGL
 nfBdCrFM2lzZk5ShJLZxWlxhg9RVGj1yVrsIvlIj5OkfTFuAghoyGnOk1sAbHJeTT6s547jtH
 o/Vx7p5vLG68b2S//QnN2tmil5slmzdKGhm/En1WuXYHG9tsJz22zdb9uw7l3vhc9ePxYbIDf
 pOmUo55iu3edW4qFybbrQMmXme/UDq3HhIQHDlOVHelEf1j0ZgAaylBRWC+edFEZn1gkxGzy3
 IomqGio/RICG1faUAl5FPeF2CTH4MZ+MRuWnBmhJLJyL/VULQ+2fidK746VzaxVdP/j9/TNKO
 rEVYv+rqhpLuc7dmjCQnYZV7uOmXvwcSs/jkgFABFMkAkRN8fHEoKjsAIZkZfxL13hPnAZK2Y
 DQ+Miw7RjdRKow9+PX4jrRBvwv2x7KWhicQ0W96eBz8IBb9lMt+ATqblHh1++DO1npdT0yWUO
 Z6nSADN6BSIRdlVuxo0KnwB//z6fLh6S/VC9kQgNni8/gdm8ytNs8bo/KGGcNxpIwgbHX4nMH
 KsIrifiNOi9yy9+lWmMfv1vBg1xZEEt+6W2a81TY61uck7FIZ6DI5KiPidtakzDr6OvM+poUe
 vL3CzqsC7WCCkP3jUIHqVhMy0wJR9/c2WETexiU5m8LPxE1FhfgmoEXwdFHgKl/uSqic0SOnY
 Yb3J/L6NPAR+h1DcPh47UfUzAVFmEIgwuQEcYNRhwT6WFdfavcGuNoSaJT6lbClpTxYNOpwL+
 19F0Nwcena5nmaFgtMsYJ5qL3yAnt3icxQE22p/TqW6R7TOxViTaRv++ZMWlvxdGIvXlBHTwn
 3Ax3kpQff3Ei0rSK7/KYp1QZOO1xuwtgcxVQEJSpL24AhlfOphe7opZukhCiMM5XkvCAUuOaU
 Geky2o1DKhDzxnSPGHB1pxZQL/06AG3DVNe1ADllrZX55op4bFAtbmT/UGxZMUbv9pD2keRiN
 NPn9RRmghsSAyb/wlF8OPUccXd1220PYvzRlTu058i0MfrHqVYKuUTU0oIsRnAH2BXg0dMyEP
 49sF6GtI9T3A8ZODg8LFxXmbUeT5ZZ3rNgvClC+l0CDCZOzMpcjL+S2G+VBhWKEQFgtUiYBzK
 gLMQvmSCLdq57vBKzoVvePGHHJnPx5/HbtvkCRCuzPQ9JZ4/BeGAieGCUot1puHZMlVI1qaa1
 OIKuftbrLO9lwNsgyRA3U+0BTDEpU7qb3YCF+/CRERq38wJCK1CoHPm91jPrWueEsLiFgE6cP
 wTq1BuM8j8V4Reg2l5sV79CIDEXuaqZsQ/a3xMSdefLWDQG8viPO4xpjcl1rqMW9xmeW7HSOG
 ObY8ZL48YuHmzXeZwWQj+nXhMc=

Callers can use this feedback to be more aggressive in making space for
allocations of a cgroup if they know it is protected.

These are counterparts to memcg's mem_cgroup_below_{min,low}.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 include/linux/cgroup_dmem.h | 16 +++++++++++++++
 kernel/cgroup/dmem.c        | 48 ++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736e26847578e81377e40504bbba90f..1a88cd0c9eb00409ddd07d1f06=
eb63d2e55e8805 100644
=2D-- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -24,6 +24,10 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state=
 *pool, u64 size);
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limi=
t_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
 				      bool ignore_low, bool *ret_hit_low);
+bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
+			   struct dmem_cgroup_pool_state *test);
+bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
+			   struct dmem_cgroup_pool_state *test);
=20
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
 #else
@@ -59,6 +63,18 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgrou=
p_pool_state *limit_pool,
 	return true;
 }
=20
+static inline bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *r=
oot,
+					 struct dmem_cgroup_pool_state *test)
+{
+	return false;
+}
+
+static inline bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *r=
oot,
+					 struct dmem_cgroup_pool_state *test)
+{
+	return false;
+}
+
 static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_sta=
te *pool)
 { }
=20
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 10b63433f05737cc43a87029f2306147283a77ff..ece23f77f197f1b2da3ee322ff=
176460801907c6 100644
=2D-- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -641,6 +641,54 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region =
*region, u64 size,
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_try_charge);
=20
+/**
+ * dmem_cgroup_below_min() - Tests whether current usage is within min li=
mit.
+ *
+ * @root: Root of the subtree to calculate protection for, or NULL to cal=
culate global protection.
+ * @test: The pool to test the usage/min limit of.
+ *
+ * Return: true if usage is below min and the cgroup is protected, false =
otherwise.
+ */
+bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
+			   struct dmem_cgroup_pool_state *test)
+{
+	if (root =3D=3D test || !pool_parent(test))
+		return false;
+
+	if (!root) {
+		for (root =3D test; pool_parent(root); root =3D pool_parent(root))
+			{}
+	}
+
+	dmem_cgroup_calculate_protection(root, test);
+	return page_counter_read(&test->cnt) <=3D READ_ONCE(test->cnt.emin);
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_below_min);
+
+/**
+ * dmem_cgroup_below_low() - Tests whether current usage is within low li=
mit.
+ *
+ * @root: Root of the subtree to calculate protection for, or NULL to cal=
culate global protection.
+ * @test: The pool to test the usage/low limit of.
+ *
+ * Return: true if usage is below low and the cgroup is protected, false =
otherwise.
+ */
+bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
+			   struct dmem_cgroup_pool_state *test)
+{
+	if (root =3D=3D test || !pool_parent(test))
+		return false;
+
+	if (!root) {
+		for (root =3D test; pool_parent(root); root =3D pool_parent(root))
+			{}
+	}
+
+	dmem_cgroup_calculate_protection(root, test);
+	return page_counter_read(&test->cnt) <=3D READ_ONCE(test->cnt.elow);
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
+
 static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
 {
 	struct dmem_cgroup_region *region;

=2D-=20
2.51.0


