Return-Path: <cgroups+bounces-7295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975BAA78F18
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 14:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3046B171E6D
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF21323A9B4;
	Wed,  2 Apr 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b2Sh/U7m"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCE23A58B
	for <cgroups@vger.kernel.org>; Wed,  2 Apr 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598183; cv=none; b=dMgjlcQ82loY1l7ooIKxm9CK7Dy4sq72UnXYkt2ssEJ2eYHD9b0XIinVkSO4KBbTNPNz3xLVkI1GUEMe1UQPo+DcfmN3i5I38g2GDNC7O3rpV3V6sh7988sHq7dKV3ZvtrSoFhaCYN9lyk2QedCnT6OHwxGjK0z51iN9cDYuY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598183; c=relaxed/simple;
	bh=aUi/Z8n9TTXLD5/8gJowzSAxrFxKSyhU6TOADq4w1uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/o6L61e+1tFqGaQq+PwwGj/XA10Ql6/hfMlpPMjGWx2xongt9PH3eMHkaULUuNkHgGw/KpEmcd2EV6IVjyiw+tVaBBNzOlb5u76nvwdozPmTLhkNVhdl/lsgR9qWsM5jp6M1029A6I6gbguTpbtfEUxCR563X5/HEjSCI40zjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b2Sh/U7m; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso31081335e9.3
        for <cgroups@vger.kernel.org>; Wed, 02 Apr 2025 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743598180; x=1744202980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUi/Z8n9TTXLD5/8gJowzSAxrFxKSyhU6TOADq4w1uo=;
        b=b2Sh/U7mr6oQzismt9NyLTxXITaBcbJLsTKvOQ0FOZyWNLzpAhqR62wiqJw5Gs1gqN
         biQr0R34j621HFPCPFwR/a96V1tlkC7Tm72QrtLussMGWP+3vtgnG4A1olLlUc34KNew
         WyghTFcBzojli/Ley5VIiG0FxtZDT+d++/Ket9aV0Tb9HkalhHk1iZXukHofviFmN9nf
         H1IAoCcm/tunke2zSCfxinnVbtMwnl2+FSFKlatx6aUwaONsdfEuR31w0AebiFzq95CT
         vMgpfv0leGJjSCPI5VMP5ERCctl50vdU30IyXRY0x8AI1JNi2m/5ZURMT3xlb0mI0zwj
         5wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743598180; x=1744202980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUi/Z8n9TTXLD5/8gJowzSAxrFxKSyhU6TOADq4w1uo=;
        b=Ih+MrJhYSZTxquTMHx02cWVS6MD+20mT1WXWT5+y2tGvcZw13KuZPv8jbKaH/HzlFS
         98aKhxSeCuX1ZMBUOpJnfNlCfNpFKxpiMfWuwfSET66c+wr/Rlbi5vs/Gb64+i+jNM5+
         AXFXbeFlDgTD5IALXsASuUsyxi7J8T3oq2f/fwhbTvzMWmM6ikTAAM7MofD7YJbFEYbx
         cN/7RPMSw1a+34h3aH9pG89O/o68gOR/bINkSRl6GAn9jIgU6Mr6e6XbyjMlhNgBRXJg
         ZRpptTbM59r+/iVOrs0n2rfEGvaPldv5XBlIP11tPNNm8m1CoK5b/trmuipfjK5cyNme
         yGNg==
X-Forwarded-Encrypted: i=1; AJvYcCUoD7DbBjUwdiaCGuhGCi8MIef/6nliRIhzrk3BHEu52oeOTRSZSP+7QomRg7SpTMWVP5SGl+zJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYaK8dhRYeVd1uLqm+7r4QPQpEqpPkX9FiqBQ2A5S1izR96Pv
	6QnG1k8T134gO0Olu/TlbV3QTaoX3vzFmb0+eqgED9EtwDQO0EEP2F5MhESohhk=
X-Gm-Gg: ASbGncuvqHVvDyKJUv08b/yylXCw0Ej1pUA1tNWKYNN+cYbJuziykBAMEE8TpFPQo4P
	AjLb3h9NbO2H+AsVmKd3l+WMkGWsJCQE58AaIxrBs6w0fydQTGTh5jOK7ekTV722FLPYdOEfmyn
	CgC6Cxjd2TjUI4I+YEaSWjznUsmhNq1qmz9gRzjKk2N0ikjyzXEv29AGiddaLHTyIuI/6MMALRC
	IDgtnQ2Pkn/9LR9kOtRiIq+mH3JPcABMhFu1YFNNnXkkF94FX+Uc8YH//bAkcxsmFgZlxR/Rk70
	2y5jKJAw99vRs7s0mi2ryGV2coUN9vhi6Twy3JWgv9J9JoI15w/2HSg6gg==
X-Google-Smtp-Source: AGHT+IHA46HXuPsXbY5rxefnfJga1zY4ePIGw6eCqg+pFZUSEaQdfx7+YGmvIZW2a9SOFb5L7a+GUg==
X-Received: by 2002:a05:600c:4f0e:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-43db61b3623mr137169545e9.6.1743598179759;
        Wed, 02 Apr 2025 05:49:39 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb61116ffsm20164135e9.32.2025.04.02.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 05:49:39 -0700 (PDT)
Date: Wed, 2 Apr 2025 14:49:37 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Waiman Long <longman@redhat.com>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shinya.Takumi@sony.com" <Shinya.Takumi@sony.com>
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Message-ID: <sgwmpdabmhcu3h7yxxjq3x4n6hk6p4m5bsopimfbmt46lokj7k@c4oood4anage>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
 <thhej7ngafu6ivtpcjs2czjidd5xqwihvrgqskvcrd3w65fnp4@inmu3wuofcpr>
 <OSZPR01MB67118A17B171687DB2F6FBC993CA2@OSZPR01MB6711.jpnprd01.prod.outlook.com>
 <2vvwedzioiopvjhah4jxlc6a5gq4uayyj2s5gtjs455yojkhnn@rkxanxmh3hmu>
 <OSZPR01MB6711D710EC3199A654434D6193A02@OSZPR01MB6711.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2kufip5v65ii35bl"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB6711D710EC3199A654434D6193A02@OSZPR01MB6711.jpnprd01.prod.outlook.com>


--2kufip5v65ii35bl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
MIME-Version: 1.0

Hello.

On Fri, Mar 28, 2025 at 10:45:02AM +0000, "Shashank.Mahadasyam@sony.com" <S=
hashank.Mahadasyam@sony.com> wrote:
> Given the different scheduling classes (fair, ext, rt, deadline), it woul=
d be nice
> to document which cpu interface files are related to which scheduling cla=
sses.
> Like, cpu.idle applies to only the fair class, cpu.weight applies to the =
fair class,
> as well as ext, if configured so, cpu.stat accounts for all classes
> (I'm not sure about this, I haven't tested this yet), etc.
>=20
> The proposed patch is in this direction, but just for the rt class. Any s=
uggestions
> on how this intent can be made clearer? How about something like this:

Classes are implementation terminology but userspace knows this under
scheduling policies (SCHED_NORMAL,..., SCHED_EXT). It might be better to
use that categories.

>=20
> CPU Interface Files
> ~~~~~~~~~~~~~~~~~~~
>=20
> All time durations are in microseconds. The scheduling classes mentioned =
beside
> the interface files are the only classes they are related to.

list of related <categories> is only indicative as implementation may change

(Even when talking about policies I think the relation still tends to be
an implementation detail, so I'd also add something like the above. But
I think it's good to have such an overview to know what is where
implemented.)

HTH,
Michal

--2kufip5v65ii35bl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+0yXwAKCRAt3Wney77B
Sen5AP0ZtZaIVCRo3cNtvvg0SOpN8uIKAvPRV5GdXzTIPDZ08AEA/czSx5CfQ1db
EXVjwOZJPy3XFWGw9czhrUmytYWk5gs=
=HEly
-----END PGP SIGNATURE-----

--2kufip5v65ii35bl--

