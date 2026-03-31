Return-Path: <cgroups+bounces-15124-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHjNBiSLy2kuIwYAu9opvQ
	(envelope-from <cgroups+bounces-15124-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 10:51:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF56E366740
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16BAB304E35C
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CED53ECBE3;
	Tue, 31 Mar 2026 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at2LFaho"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354B3ECBC9
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946890; cv=none; b=U//AlVNJNqInsqpR/d4IFgRK/jZjKhKVlVHvxKahHXJWTGp8xNLdxbY3IcZH4M5jel+RFMsCrcXI/wNTM++ufddkRJvR7/MS6G/95+FQ0++NvNR3ZWtRijz4h9X67IlfDExtN0QA8cDKnp0bV7X4CYbOezK8FzuedrmOK5BYYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946890; c=relaxed/simple;
	bh=GqZ9dtf012/tvEDtWtiGgPVpZrgivQfQdYmt0+ibfYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO7F/TBIb+SxtFGSkva5vgx6tG827R7tMCSZUczt3rhIXpIcVqRXBxkd5NwEL0nPNwV5SeKmPi+IwqL4Z6WuB+JMgXqZGFlzQGRXPQUuc2ov3Vhslzj2MdhOeeZRZ56LdIbTLVkXyIRk7dKOcBdx837K144J7rXWjVIjIudrcQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at2LFaho; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c742882d2a4so2282562a12.0
        for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 01:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774946888; x=1775551688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/+/5DmEREtPh/G6RQZ9rjczhP8Bu3IGm6So6inYdb0=;
        b=at2LFahokVkGR1RJFQEZwdBjJBez3zSylXjqjidNcXhHUHqnNb1z2AVPzlQMTnr1R5
         m5S5IwvIxSiCAF45RLq6vM4jYdroN92nSGy0//ENBI3keRkBACfV3m4ZpL4IMzhYEa6I
         KzXkV026F+KfuCpyPRTo8gXZMRr+CFoe0OU0gZmUlWFb5FBK3uvY7UTPBOxflX1TkPz7
         T3HYDbNXqRGZhQ2xZddsKmD65vUeyUletMJLnA+HgMOF8c9dRYb7If6oIGH4XjmuX8ob
         QUo7l8X382SN7x4VW20EArVLf5LkqFC+xEeAP6IlhVm1BOogTEUa8G+sb/GwAREJVh5R
         SmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946888; x=1775551688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/+/5DmEREtPh/G6RQZ9rjczhP8Bu3IGm6So6inYdb0=;
        b=WP2iwJ9kCv+K4WRAVc5aWQFyb+eRPeFS2cVrE2VD7tlTyWo93lDJul6vN4i9eSgsK+
         NSO/gTqL1p6mzBkT/9hoFG8FJk40IrSl29iRP3OfqrtFtk1vGTYsNiQ5xMLo/DI65IYV
         mxQ9KNc5c9CIjH2DQOjkoFPOZ/9X4/CPZpdK0IqhHIR27JnyYzTyZEa3hM4mNUxZpqTI
         3Dpmgg+eXk1OOPmW+KK02poWXwVnbpL7sB6nBKrNKIk4YEJdHP5gMRJkh7dnTuwKP0ng
         TmxBXsdu8BZoMXzDcbpFJeH+TRBQ3GGRN5bVPp6yIzJVbtOPJ3QsUFyER7D+uV3N4xoq
         am7g==
X-Forwarded-Encrypted: i=1; AJvYcCUrLEFJr95+cuosviNHd9yREaFVLb8mOK/gLhuXEhL8dE8UQjAZVvweed65OyrU3f85mJyIqKEd@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlaqviG2jg3i/4N+PLaaaQTGr80p0Jp1VoFWFdsP4kI6pAfvn
	OQIu5L5STB+HHIKZflQfXIWPO8fUoFSAUL8su2Du6GgPxiWRBklrsmdW
X-Gm-Gg: ATEYQzw7De2o87uflUbEB5xz+kfzbIgs0HY11ra4+gMFu8s4zJe1n8mC1RXhraSd5Pp
	+UUMZRFtD7QH1LJKeKXTrVHswoxbJy0wDSGT/uuyQTHyXSlJALzH+8Asnj4xj7DsuYzznAthUwu
	FZReRvXrcMgiH9CiarbFpJJIsaTfZ19xnzvozHQTu1dzTSXaztMjl4YVllOR/U6/BGm9OE+6Tvh
	U8FjH1g7PRMC0WhgwCeoP8qlhAUpcJWercQSbOFx2mdI9jtpSddhKdN6ps+qiwYhKedTNifGwDs
	yA0sozezvwYZkiqevFiGcT8acg2YF/ESGikm33b4+wmVawpfxr12C2oySzTSPKPV2/crioeVeN7
	027vJ4O3o6snZyNAh9EqidQE5iM0y5ggGaFkwpHivxwny65yM3AsZFnSK72xtkLjBGr107L01z/
	H/Zq2fMiqIJSj8LxjQ0BdMqmp06E9T2SOW76N4CzdhlkELCg+RiaAgBOlq
X-Received: by 2002:a17:902:e54f:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2b0cd9e7b8bmr160264955ad.0.1774946887943;
        Tue, 31 Mar 2026 01:48:07 -0700 (PDT)
Received: from archwsl.localdomain ([223.166.78.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c4cafsm111673745ad.81.2026.03.31.01.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 01:48:07 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: tj@kernel.org
Cc: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wjl.linux@gmail.com
Subject: Re: [PATCH v2] blk-iocost: fix busy_level reset when no IOs complete
Date: Tue, 31 Mar 2026 08:48:04 +0000
Message-ID: <20260331084804.146325-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <acrM1flqKQlcONbL@slm.duckdns.org>
References: <acrM1flqKQlcONbL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,toxicpanda.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15124-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wjllinux@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF56E366740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, Mar 30, 2026 at 09:19:49AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Mar 29, 2026 at 03:41:12PM +0000, Jialin Wang wrote:
> ...
> > Before:
> >   CGROUP   IOPS   MB/s    Avg(ms)  Max(ms)  P90(ms)  P99      P99.9    P99.99
> > 
> >   cgA-1m   167    167.02  748.65   1641.43  960.50   1551.89  1635.78  1635.78
> >   cgB-4k   5      0.02    190.57   806.84   742.39   809.50   809.50   809.50
> > 
> >   cgA-1m   166    166.36  751.38   1744.31  994.05   1451.23  1736.44  1736.44
> >   cgB-32k  4      0.14    225.71   1057.25  759.17   1061.16  1061.16  1061.16
> > 
> >   cgA-1m   166    165.91  751.48   1610.94  1010.83  1417.67  1602.22  1619.00
> >   cgB-256k 5      1.26    198.50   1046.30  742.39   1044.38  1044.38  1044.38
> > 
> > After:
> >   CGROUP   IOPS   MB/s    Avg(ms)  Max(ms)  P90(ms)  P99      P99.9    P99.99
> > 
> >   cgA-1m   159    158.59  769.06   828.52   809.50   817.89   826.28   826.28
> >   cgB-4k   200    0.78    2.01     26.11    2.87     6.26     12.39    26.08
> > 
> >   cgA-1m   147    146.84  832.05   985.80   943.72   960.50   985.66   985.66
> >   cgB-32k  200    6.25    2.82     71.05    3.42     15.40    50.07    70.78
> > 
> >   cgA-1m   114    114.47  1044.98  1294.48  1199.57  1283.46  1300.23  1300.23
> >   cgB-256k 200    50.00   4.01     34.49    5.08     15.66    30.54    34.34
> 
> Are the latency numbers end-to-end or on-device? If former, can you provide
> on-device numbers? What period duration are you using?

These latency numbers are completion latency results from fio using
ioengine=libaio. For cgB, since --iodepth=1 is used, these completion
latencies are very close to the actual on-device times.

I used the following QoS parameters:
rpct=90 rlat=3500 wpct=90 wlat=3500 min=80 max=10000 (period: 7ms)

When switching to:
rpct=80 rlat=10000 wpct=80 wlat=10000 min=80 max=10000 (period: 40ms)
While this showed some improvement, cgB still failed to reach the
expected 200 IOPS, and the P99 latency remained high:

CGROUP   IOPS   MB/s    Avg(ms)  Max(ms)  P90(ms)  P99      P99.9    P99.99

cgA-1m   161    160.81  758.52   1462.38  1044.38  1317.01  1451.23  1468.01
cgB-4k   125    0.49    7.18     661.39   2.70     189.79   650.12   658.51

cgA-1m   155    154.63  784.92   1234.01  1010.83  1182.79  1233.13  1233.13
cgB-32k  136    4.26    6.40     300.78   3.85     160.43   295.70   299.89

cgA-1m   138    137.91  860.32   1704.14  1317.01  1669.33  1702.89  1702.89
cgB-256k 95     23.70   9.83     394.73   5.34     206.57   396.36   396.36

I also tested several other sets of parameters and the results were similar.
Using bpftrace, it can still be frequently observed that busy_level is
reset to 0 when no IO complete, and the vrate cannot be lowered in time.

08:26:20.186950 iocost_ioc_vrate_adj: [sdb] vrate=127.50%->126.23% busy=4 missed_ppm=1000000:1000000 rq_wait_pct=0 lagging=3 shortages=1
08:26:20.220910 ioc_rqos_done
08:26:20.222616 ioc_rqos_done
08:26:20.226913 ioc_rqos_done
08:26:20.227951 iocost_ioc_vrate_adj: [sdb] vrate=126.23%->124.97% busy=5 missed_ppm=1000000:1000000 rq_wait_pct=0 lagging=3 shortages=1
 -- no IO complete, busy_level was reset to 0 --
08:26:20.268945 iocost_ioc_vrate_adj: [sdb] vrate=124.97%->124.97% busy=0 missed_ppm=0:0 rq_wait_pct=0 lagging=3 shortages=1

bpftrace -e '
#define VTIME_PER_USEC 137438

kfunc:ioc_rqos_done
{
	printf("%s ioc_rqos_done\n", strftime("%H:%M:%S.%f", nsecs));
}

tracepoint:iocost:iocost_ioc_vrate_adj
{
	$old_vrate = args->old_vrate * 10000 / VTIME_PER_USEC;
	$new_vrate = args->new_vrate * 10000 / VTIME_PER_USEC;

	printf("%s iocost_ioc_vrate_adj: [%s] vrate=%d.%02d%%->%d.%02d%% busy=%d missed_ppm=%u:%u rq_wait_pct=%u lagging=%d shortages=%d\n",
	       strftime("%H:%M:%S.%f", nsecs), str(args->devname),
	       $old_vrate / 100, $old_vrate % 100, $new_vrate / 100,
	       $new_vrate % 100, args->busy_level, args->read_missed_ppm,
	       args->write_missed_ppm, args->rq_wait_pct, args->nr_lagging,
	       args->nr_shortages);
}'

> > @@ -2397,9 +2400,29 @@ static void ioc_timer_fn(struct timer_list *timer)
> >  	 * and should increase vtime rate.
> >  	 */
> >  	prev_busy_level = ioc->busy_level;
> > -	if (rq_wait_pct > RQ_WAIT_BUSY_PCT ||
> > -	    missed_ppm[READ] > ppm_rthr ||
> > -	    missed_ppm[WRITE] > ppm_wthr) {
> > +	if (!nr_done) {
> > +		if (nr_lagging)
> 
> Please use {} even when it's just comments that makes the bodies multi-line.
> 
> > +			/*
> > +			 * When there are lagging IOs but no completions, we
> > +			 * don't know if the IO latency will meet the QoS
> > +			 * targets. The disk might be saturated or not. We
> > +			 * should not reset busy_level to 0 (which would
> > +			 * prevent vrate from scaling up or down), but rather
> > +			 * try to keep it unchanged. To avoid drastic vrate
> > +			 * oscillations, we clamp it between -4 and 4.
> > +			 */
> > +			ioc->busy_level = clamp(ioc->busy_level, -4, 4);
> 
> Is this from some observed behavior or just out of intuition? The
> justification seems a bit flimsy. Why -4 and 4?

During my testing with the parameters rpct=90 rlat=3500 wpct=90 wlat=3500
min=10 max=10000, I noticed that vrate occasionally drops significantly
(down to 50% or lower), which adversely impacted the IOPS of cgA. So I
limit the busy_level to a maximum of 4 to reduce vrate at the lowest speed.

CGROUP   IOPS   MB/s    Avg(ms)  Max(ms)  P90(ms)  P99      P99.9    P99.99  
cgA-1m   137    137.11  891.21   1278.66  1082.13  1216.35  1266.68  1283.46
cgB-4k   200    0.78    2.12     62.64    2.47     7.44     49.55    62.65

I realized that raising min to 80 would effectively mitigate this issue,
so I will remove it in the next v3.

> > +		else if (nr_shortages)
> > +			/*
> > +			 * The vrate might be too low to issue any IOs. We
> > +			 * should allow vrate to increase but not decrease.
> > +			 */
> > +			ioc->busy_level = min(ioc->busy_level, 0);
> 
> So, this is no completion, no lagging and shortages case. In the existing
> code, this would alos get busy_level-- to get things moving. Wouldn't this
> path need that too? Or rather, would it make more sense to handle !nr_done
> && nr_lagging case and leave the other cases as-are?

That's a fair point. My initial thought was not to adjust busy_level
when there is no latency data, and I haven't observed this specific path
(no completions, no lagging, but with shortages) occurring in my testing
so far, so I might have been overthinking it. I will simplify the logic
in v3 to handle only the !nr_done && nr_lagging case and leave the other
cases as they are.

-- 
Thanks,
Jialin

