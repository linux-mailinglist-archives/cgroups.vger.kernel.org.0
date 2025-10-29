Return-Path: <cgroups+bounces-11318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A75C18CE5
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 08:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E443BB161
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239730FC25;
	Wed, 29 Oct 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR1w2pes"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22C30DD33
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724356; cv=none; b=A8MG9pcgmOyURkdjeKaN7ilef/Qv8nZGGw+QU8MTscMea/SONxXDMyVnMn1hfTYZX+CliKXkqNMFiRBLmCVgrOsdUouoGN1BGdo6q2uf13WYW9t4WpZKS3oTER7pwP9JMWlncG/tGQa7iwEYBOvs78Ge6BF7MyEno1j0Dh+SULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724356; c=relaxed/simple;
	bh=d+3F8ifPRHXFbWiCU0mXGYHLj7wBVR6XNBd6P3QTX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHlbkv+8wUkpg3zVmkxQhsLxEnVab2/NZh/9QyF/3Rw9U/gWJGWaELDMDTGbdnYFkRwj2WFSJ+lRAhlLhVSE6mAnWhB3g9bQBwwqfE1rjZT1sRaRgAmlAIYDYDUneju0eOobdlexxXxsPMNJuMAUEOxNNUBBhci0UpIHQUjbolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR1w2pes; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1306629166b.0
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724354; x=1762329154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkFkfoX1+/bTv24rgjMgjWItS99qE5Oq3y2IeAjCaqE=;
        b=KR1w2pesO82Pos8i6pVakPIU2Ju7r+z/lQWWaNwG3VE1qXU+DlQjKvSevc7krHnlB2
         Z6Y8pM0EjcVcuYLttLENggrIYO+50ULTHbX/fBh0zvmVIdhbs+BRq0foCqIzwAg/hk/C
         vMR6lYkATzJD6WMxgUXtPSXrweyKTDtzj/E3/kAS5OL9ORjCnVSW4Za94+FESuKtiILG
         dD9QnX8VQDJSL/j15xbyIw62HH5kWs1NLUk0jxyUtMdAR33G/iZe8YrXBcERUs2pDtWT
         CuBraA6gRrDIyeoprzOXcGqDXuTtj0pHU58AeesgJE7gGIhOb743FxAsXh4VuqIcy9Vh
         hX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724354; x=1762329154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkFkfoX1+/bTv24rgjMgjWItS99qE5Oq3y2IeAjCaqE=;
        b=adizECSb0Me/uI2ibeBwwjBYAJ5FfklZibQxuYs9iR8273E1WaByU5KisYZl++fhe0
         7ZCfeL+6zS1zqPqPguCaeGBwZSakixYczGMC/qASnqsTyQ+y8Kfte+IRECaQJV/A+7Ys
         3cYS66GSpEw1v3sdIul0rfczUigzP4ykh6dCTspGfZT7jqsZEwwpQOLqA83RdqVFHIvU
         WHTvjZHVHVxrhWqSyoM/T3E8V5VizeK4lrRaDxA3xGOQDPLKfEHEmwkwZ9eU8y+qBbC7
         EBxi7voumtJAw8mF7zVViDq5z7qvaPoGuIFaJWTS75JJfC8V2XZwgTvg1OyOcKmaxlFT
         rUqw==
X-Forwarded-Encrypted: i=1; AJvYcCUl1jCHchKbGhnyD80RSp6TZxC1cE7pfHLZ2fTRa75LaMeLS/8AGamuEZBPBvq5f1P7qMbwI43y@vger.kernel.org
X-Gm-Message-State: AOJu0YybzJpKsSZJrVMBr5Cj3KhBzDu7oeyLCUlHrNXdOzEddGqhir4Q
	X8yvaQGqHsifIznyBk77ZlwqGpM99NHsUxKl390lyAxAbx/kMc+pG9nL
X-Gm-Gg: ASbGnctCSq7gCskLV5KepGEC77h0dX1ASs2yuoFwlMWKV6dzeh9yOOZiJ92RTDW90UU
	hntsyyD8AxkY+s6xwusdbkssMw6RecRoHpuCpQySOhxcLTJL2LEr9D/Ful6Z8qB8VRS98yWeWS0
	tWbsMtM0Z4+FiZyPQ9Rcl9Ogq6p3Elu4zE2X3gQgh21Sr90F74B9hdKKULIAZWqIhmjr7A+OyO4
	aGIy6mJK4ow+j13oUPT8IG9QpPCzMfE2HU/vVxdNQFlASRe40IrVA54TqfS32H4hw+xE3q8e9Ez
	3ksrTpyCRuMtTfKdetcyeBmDXvVs0Ig+Z5p3BPZ1agOK2flC1johiy+isNgFyfqIgnsZjh3QWcR
	/eoKn0tPuwKVfeGsvbzjD69flXW8CZIWhMBUWcs8ANflD6AzrcNHBEbfb3lx/KHo6ob4c7HS8XX
	cN
X-Google-Smtp-Source: AGHT+IHtSgmrBsC3MRR28mflYTkgpLevXtnHQXIDSUigDzjREnxXOwaBD8WEsWGS3KPcLidmHJbHaA==
X-Received: by 2002:a17:907:971f:b0:b5b:2c82:7dc6 with SMTP id a640c23a62f3a-b703d4f7df3mr180499066b.40.1761724353666;
        Wed, 29 Oct 2025 00:52:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d85445d48sm1331864766b.65.2025.10.29.00.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 00:52:33 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	jannh@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@yhndnzj.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v3 17/70] nstree: add listns()
Date: Wed, 29 Oct 2025 10:52:26 +0300
Message-ID: <20251029075226.2330625-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> 2. Incomplete - misses inactive namespaces that aren't attached to any
>    running process but are kept alive by file descriptors, bind mounts,
>    or parent namespace references

I don't like word "inactive" here. As well as I understand, it is used in
a sense, which is different from later:

> (3) Visibility:
>     - Only "active" namespaces are listed

-- 
Askar Safin

